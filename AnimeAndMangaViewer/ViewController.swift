//
//  ViewController.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
}
// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfType
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = viewModel.typeTitle(indexPath: indexPath)
        return cell
    }
}
// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = viewModel.getType(indexPath: indexPath) else { return }
        let vc = SubTypeVc(nibName: "SubTypeVc", bundle: nil)
        let subViewModel = SubTypeViewModel(type: type)
        vc.setupViewModel(subViewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

private extension ViewController {
    var cellId: String { "cellId" }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
}
