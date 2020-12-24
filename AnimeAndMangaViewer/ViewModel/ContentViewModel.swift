//
//  ContentViewModel.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/24.
//

import Foundation

class ContentViewModel {
    private let model: ContentModel
    private weak var delegate: ContentTableViewCellViewModelDelegate?
    
    init(model: ContentModel, delegate: ContentTableViewCellViewModelDelegate?) {
        self.model = model
        self.delegate = delegate
    }
}

extension ContentViewModel {
    var numberOfRow: Int {
        10
    }
    
    func subViewModel(indexPatj: IndexPath) -> ContentTableViewCellViewModel {
        ContentTableViewCellViewModel(model: TopModel.dummyModel, delegate: delegate)
    }
}
