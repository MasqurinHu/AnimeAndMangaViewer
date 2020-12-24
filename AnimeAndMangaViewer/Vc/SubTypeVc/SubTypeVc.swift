//
//  SubTypeVc.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/24.
//

import UIKit

class SubTypeVc: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private var viewModel: SubTypeViewModel?
}

extension SubTypeVc: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfSubType ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = viewModel?.subTypeTitle(indexPath: indexPath)
        return cell
    }
}

extension SubTypeVc: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel?.getContentModel(indexPath: indexPath) else { return }
        let contentViewModel = ContentViewModel(model: model, delegate: self)
        let vc = ListVc(nibName: "ListVc", bundle: nil)
        vc.setupViewModel(contentViewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension SubTypeVc: ContentTableViewCellViewModelDelegate {
    
    func showWebView(url: URL?) {
        let vc = WebVc()
        vc.url = url
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SubTypeVc {
    
    func setupViewModel(_ viewModel: SubTypeViewModel) {
        self.viewModel = viewModel
    }
}

private extension SubTypeVc {
    var cellId: String { "cellId" }
    
    func setup() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
}
