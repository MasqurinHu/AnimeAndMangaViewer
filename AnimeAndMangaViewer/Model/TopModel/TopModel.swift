//
//  TopModel.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/23.
//

import Foundation

struct TopModel: Decodable {
    let malId: Int
    let imageUrl: String?
    let title: String
    let rank: Int
    let startDate: String?
    let endDate: String?
    let type: String
    let url: String?

    static let dummyModel = TopModel(
        malId: 1,
        imageUrl: "https://img.ttshow.tw/images/media/uploads/2019/11/28/d1654223.jpg",
        title: "Dr. Stone: Stone Wars",
        rank: 1,
        startDate: "Jan 2021",
        endDate: nil,
        type: "TV", url: "https://myanimelist.net/anime/40852/Dr_Stone__Stone_Wars")
}

