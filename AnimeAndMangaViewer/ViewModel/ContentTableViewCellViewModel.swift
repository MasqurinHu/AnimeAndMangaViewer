//
//  ContentTableViewCellViewModel.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/24.
//

import Foundation

protocol ContentTableViewCellViewModelDelegate: AnyObject {
    func showWebView(url: URL?)
}

class ContentTableViewCellViewModel {
    var isFavorite: ((Bool) -> Void)? {
        didSet {
            isFavorite?(dbRepo.fetchFavorite(model: model))
        }
    }
    init(model: TopModel,
         dbRepo: DbRepository,
         delegate: ContentTableViewCellViewModelDelegate?) {
        self.model = model
        self.delegate = delegate
        self.dbRepo = dbRepo
    }

    private let model: TopModel
    private let dbRepo: DbRepository
    private weak var delegate: ContentTableViewCellViewModelDelegate?
}

extension ContentTableViewCellViewModel: Equatable {
    static func == (lhs: ContentTableViewCellViewModel, rhs: ContentTableViewCellViewModel) -> Bool {
        lhs.model == rhs.model
    }
}

extension ContentTableViewCellViewModel {
    static var cellType: AnyClass? { ContentTableViewCell.self }
    static var cellId: String { "ContentTableViewCell" }

    var cellType: AnyClass? { ContentTableViewCell.self }
    var cellId: String { "ContentTableViewCell" }
    var title: String { "title: " + model.title }
    var rank: String { "rank: \(model.rank)" }
    var startDate: String { "startDate: " + (model.startDate ?? "--") }
    var endDate: String { "endDate: " + (model.endDate ?? "--") }
    var type: String { "type: " + model.type }
    var urlString: String? { model.url }
    var malId: String { "malId: \(model.malId)" }
    var imgUrl: URL? {
        guard let string = model.imageUrl else { return nil }
        return URL(string: string)
    }

    func favoriteAction() {
        dbRepo.setFavorite(!dbRepo.fetchFavorite(model: model), model: model) { [weak self] result in
            switch result {
            case .success(let isFavorite):
                self?.isFavorite?(isFavorite)
            case .failure:
                break
            }
        }
    }

    func urlAction() {
        guard let string = model.url?.addingPercentEncoding(withAllowedCharacters: .alphanumerics)?.removingPercentEncoding else { return }
        let url = URL(string: string)
        delegate?.showWebView(url: url)
    }
}
