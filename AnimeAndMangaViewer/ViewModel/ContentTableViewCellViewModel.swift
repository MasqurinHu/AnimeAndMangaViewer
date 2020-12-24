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
            isFavorite?(favoriteStore)
        }
    }
    init(model: TopModel, delegate: ContentTableViewCellViewModelDelegate?) {
        self.model = model
        self.delegate = delegate
    }
    
    private let model: TopModel
    private var favoriteStore = false
    private weak var delegate: ContentTableViewCellViewModelDelegate?
}

extension ContentTableViewCellViewModel {
    static var cellType: AnyClass? { ContentTableViewCell.self }
    static var cellId: String { "ContentTableViewCell" }
    
    var cellType: AnyClass? { ContentTableViewCell.self }
    var cellId: String { "ContentTableViewCell" }
    
    
    var imgUrl: URL? {
        guard let string = model.imageUrl else { return nil }
        return URL(string: string)
    }
    var title: String { "title: " + model.title }
    var rank: String { "rank: \(model.rank)" }
    var startDate: String { "startDate: " + (model.startDate ?? "--") }
    var endDate: String { "endDate: " + (model.endDate ?? "--") }
    var type: String { "type: " + model.type }
    var urlString: String? { model.url }
    var malId: String { "malId: \(model.malId)" }
    
    func favoriteAction() {
        favoriteStore = !favoriteStore
        isFavorite?(favoriteStore)
    }
    
    func urlAction() {
        guard let string = model.url?.addingPercentEncoding(withAllowedCharacters: .alphanumerics)?.removingPercentEncoding else { return }
        let url = URL(string: string)
        delegate?.showWebView(url: url)
    }
}
