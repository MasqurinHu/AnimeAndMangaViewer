//
//  ApiRepository.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/24.
//

import Foundation

struct ApiRepository {}

extension ApiRepository {

    func fetchTop(
        model: ContentModel,
        page: Int,
        doneHandle: @escaping ((Result<[TopModel], Error>) -> Void)) {

        let task = TopTask(model: model, page: page)
        ApiService.request(task: task) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let mmm = try decoder.decode(Welcome<TopModel>.self, from: data)
                }
                catch {
                    print(error)
                }
                guard let model = try? decoder.decode(Welcome<TopModel>.self, from: data) else {
                    let string = String(data:data, encoding: .utf8)
                    doneHandle(.failure(NetworkError.decodeError(string)))
                    return
                }
                doneHandle(.success(model.top))
            case .failure(let error):
                doneHandle(.failure(error))
            }
        }
    }
}
