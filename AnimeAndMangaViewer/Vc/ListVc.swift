//
//  ListVc.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/24.
//

import UIKit

enum ListVcState {
    case firstLoading, loadDone, loadFail(String)
}

class ListVc: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        bindViewModel()
    }

    private var viewModel: ContentViewModel?
}

extension ListVc {
    
    func setupViewModel(_ viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
}

extension ListVc: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRow ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel?.loadMore(indexPath: indexPath)
        guard
            let viewModel = viewModel else {
            return UITableViewCell()
        }
        let subViewModel = viewModel.subViewModel(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: subViewModel.cellId, for: indexPath) as? ContentTableViewCell else {
            return UITableViewCell()
        }
        cell.setupViewModel(subViewModel)
        return cell
    }
}

private extension ListVc {
    
    func setupTableView() {
        let nib = UINib(nibName: "ContentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ContentTableViewCellViewModel.cellId)
        tableView.tableFooterView = UIView()
    }

    func bindViewModel() {
        viewModel?.needReloadData = { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}
