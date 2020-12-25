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
}

extension TopModel: Equatable {}
