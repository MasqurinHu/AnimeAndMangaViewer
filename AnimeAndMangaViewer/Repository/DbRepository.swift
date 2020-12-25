//
//  DbRepository.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/25.
//

import Foundation

struct DbRepository {
    
    init(dataSource: DbDataSourceSpec) {
        self.dataSource = dataSource
    }
    
    private let dataSource: DbDataSourceSpec
}

extension DbRepository {
    
    func fetchFavorite(model: TopModel) -> Bool {
        dataSource.fetchFavorite(model: model)
    }
    
    func setFavorite(_ isFavorite: Bool, model: TopModel, doneHandle: @escaping ((Result<Bool, Error>) -> Void)) {
        dataSource.setFavorite(isFavorite, model: model, doneHandle: doneHandle)
    }
}
