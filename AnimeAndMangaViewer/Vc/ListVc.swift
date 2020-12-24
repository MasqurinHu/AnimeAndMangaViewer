//
//  ListVc.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/24.
//

import UIKit

class ListVc: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        steupTableView()
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
        guard
            let viewModel = viewModel else {
            return UITableViewCell()
        }
        let subViewModel = viewModel.subViewModel(indexPatj: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: subViewModel.cellId, for: indexPath) as? ContentTableViewCell else {
            return UITableViewCell()
        }
        cell.setupViewModel(subViewModel)
        return cell
    }
}

private extension ListVc {
    
    func steupTableView() {
        let nib = UINib(nibName: "ContentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ContentTableViewCellViewModel.cellId)
    }
}
