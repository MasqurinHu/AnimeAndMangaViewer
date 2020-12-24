//
//  ApiService.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/23.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl(String)
    case decodeError(String?)
    case requestFailed(Error)
    case invalidData
}


struct ApiService {
    static func request(
        task: TaskSpec,
        doneHandle: @escaping (Result<Data, NetworkError>) -> Void) {

        guard let url = URL(string: task.url) else {
            doneHandle(.failure(.invalidUrl(task.url)))
            return
        }
        var request = URLRequest(url: url, timeoutInterval: 20)
        request.httpMethod = task.httpMethod.rawValue
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                doneHandle(.failure(.requestFailed(error)))
                return
            }
            guard let data = data else {
                doneHandle(.failure(.invalidData))
                return
            }
            doneHandle(.success(data))
        }.resume()
    }
}
