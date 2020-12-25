//
//  ListVc.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/24.
//

import UIKit

enum ListVcState: Equatable {
    case loading, loadDone, loadFail(String)
}

class ListVc: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        bindViewModel()
    }

    private var viewModel: ContentViewModel?
    private lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: view.frame)
        view.addSubview(indicator)
        return indicator
    }()
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
        viewModel?.observeViewState = { [weak self] vcState in
            DispatchQueue.main.async { [weak self] in
                switch vcState {
                case .loading:
                    self?.loadingView.startAnimating()
                case .loadDone:
                    self?.loadingView.stopAnimating()
                    self?.tableView.reloadData()
                case .loadFail(let errorMsg):
                    self?.loadingView.stopAnimating()
                    self?.showAlert(msg: errorMsg)
                }
            }
        }
    }

    func showAlert(msg: String) {
        let alert = UIAlertController(title: "錯誤", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "確認", style: .cancel, handler: nil)
        let retry = UIAlertAction(title: "重試", style: .default) { [weak self] _ in
            self?.viewModel?.retry()
        }
        alert.addAction(ok)
        alert.addAction(retry)
        present(alert, animated: true, completion: nil)
    }
}
