//
//  ApiDataSource.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/24.
//

import Foundation

protocol ApiDataSourceSpec {
    func fetchTop(
        model: ContentModel,
        page: Int,
        doneHandle: @escaping ((Result<Data, NetworkError>) -> Void))
}

struct ApiDataSource: ApiDataSourceSpec {

    func fetchTop(
        model: ContentModel,
        page: Int,
        doneHandle: @escaping ((Result<Data, NetworkError>) -> Void)) {

        let task = TopTask(model: model, page: page)
        return ApiService.request(task: task, doneHandle: doneHandle)
    }
}

struct DummyApiDataSource: ApiDataSourceSpec {

    func fetchTop(
        model: ContentModel,
        page: Int,
        doneHandle: @escaping ((Result<Data, NetworkError>) -> Void)) {

        guard
            let path = Bundle.main.path(forResource: "Top_anime_8_upcoming", ofType: "json"),
            let jsonString = try? String(contentsOfFile: path, encoding: .utf8),
            let jsonData = jsonString.data(using: .utf8) else {
            doneHandle(.failure(.invalidData))
            return
        }
        doneHandle(.success(jsonData))
    }
}
