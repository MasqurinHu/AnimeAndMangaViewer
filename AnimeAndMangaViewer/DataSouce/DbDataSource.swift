//
//  DbDataSource.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/25.
//

import Foundation

enum DbError: Error {
    case fetchDbError
}

protocol DbDataSourceSpec {
    func fetchFavorite(model: TopModel) -> Bool
    func setFavorite(_ isFavorite: Bool, model: TopModel, doneHandle: @escaping ((Result<Bool, Error>) -> Void))
}

class DbDataSource {
    private lazy var db: FavoriteDbModel? = fetchFavoriteDb()
}

extension DbDataSource: DbDataSourceSpec {

    func fetchFavorite(model: TopModel) -> Bool {
        db?.db[model.malId] ?? false
    }

    func setFavorite(_ isFavorite: Bool, model: TopModel, doneHandle: @escaping ((Result<Bool, Error>) -> Void)) {
        db?.db[model.malId] = isFavorite
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(db) else {
            doneHandle(.failure(DbError.fetchDbError))
            return
        }
        UserDefaults.standard.setValue(data, forKey: favoriteKey)
        doneHandle(.success(isFavorite))
    }
}

private extension DbDataSource {
    class FavoriteDbModel: Codable {
        var db: [Int: Bool] = [:]
    }

    var favoriteKey: String { "favoriteKey" }

    func fetchFavoriteDb() -> FavoriteDbModel? {
        let decoder = JSONDecoder()
        guard
            let data = UserDefaults.standard.data(forKey: favoriteKey),
            let dbModel = try? decoder.decode(FavoriteDbModel.self, from: data)
        else { return FavoriteDbModel() }
        return dbModel
    }
}

class DummyDbDataSource {
    var db: [Int: Bool] = [:]
}

extension DummyDbDataSource: DbDataSourceSpec {

    func fetchFavorite(model: TopModel) -> Bool {
        db[model.malId] ?? false
    }

    func setFavorite(_ isFavorite: Bool, model: TopModel, doneHandle: @escaping ((Result<Bool, Error>) -> Void)) {
        db[model.malId] = isFavorite
        doneHandle(.success(isFavorite))
    }
}
