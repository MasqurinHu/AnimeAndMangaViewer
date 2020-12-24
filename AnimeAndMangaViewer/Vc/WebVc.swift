//
//  WebVc.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/24.
//

import UIKit
import WebKit

class WebVc: UIViewController {
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        backBtn.isEnabled = false
    }
    
    private let webView = WKWebView()
    private let backBtn = UIButton()
    private let closeBtn = UIButton(type: .close)
}

extension WebVc: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backBtn.isEnabled = webView.canGoBack
    }
}

private extension WebVc {
    
    func setupUI() {
        view.backgroundColor = .white
        setupWebView()
        setupBtn()
    }
    
    func setupWebView() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        webView.navigationDelegate = self
        guard let url = url else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func setupBtn() {
        navigationItem.hidesBackButton = true
        backBtn.addTarget(self, action: #selector(backAction(btn:)), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(closeAction(byn:)), for: .touchUpInside)
        backBtn.setTitle("Previous page", for: .normal)
        backBtn.setTitleColor(.black, for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeBtn)
    }
    
    @objc func backAction(btn: UIButton) {
        webView.goBack()
    }
    
    @objc func closeAction(byn: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
