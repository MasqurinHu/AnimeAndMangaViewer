//
//  ContentTableViewCell.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/24.
//

import UIKit
import Kingfisher

class ContentTableViewCell: UITableViewCell {
    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var favoriteBtn: UIButton!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var rank: UILabel!
    @IBOutlet private weak var startDate: UILabel!
    @IBOutlet private weak var endDate: UILabel!
    @IBOutlet private weak var type: UILabel!
    @IBOutlet private weak var urlBtn: UIButton!
    @IBOutlet private weak var malId: UILabel!

    private var viewModel: ContentTableViewCellViewModel?

    @IBAction func favoriteAction(_ sender: Any) {
        viewModel?.favoriteAction()
    }

    @IBAction func urlAction(_ sender: Any) {
        viewModel?.urlAction()
    }
}

extension ContentTableViewCell {

    func setupViewModel(_ viewModel: ContentTableViewCellViewModel) {
        self.viewModel = viewModel
        viewModel.isFavorite = { [weak self] isFavorite in
            let title: String = isFavorite ? "favorite" : "unfavorite"
            self?.favoriteBtn.setTitle(title, for: .normal)
        }
        img.kf.setImage(with: viewModel.imgUrl)
        title.text = viewModel.title
        rank.text = viewModel.rank
        startDate.text = viewModel.startDate
        endDate.text = viewModel.endDate
        type.text = viewModel.type
        urlBtn.setTitle(viewModel.urlString, for: .normal)
        malId.text = viewModel.malId
    }
}
