//
//  TopModel.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/23.
//

import Foundation

// MARK: - AnimeModel
struct AnimeModel: TopModelSpec {
    let malID, rank: Int
    let title: String
    let url: String
    let imageURL: String
    let type: String
    let episodes: Int?
    let startDate: String?
    let endDate: String?
    let members: Int
    let score: Double
}

// MARK: - MongaModel
struct MongaModel: TopModelSpec {
    let malID, rank: Int
    let title: String
    let url: String
    let imageURL: String
    let type: String
    let volumes: Int?
    let startDate: String?
    let endDate: String?
    let members: Int
    let score: Double
}
