//
//  DummyTopModel.swift
//  AnimeAndMangaViewerTests
//
//  Created by 五加一 on 2020/12/25.
//

import Foundation
@testable import AnimeAndMangaViewer

func getDummyTopModel() -> TopModel {
    TopModel(
        malId: 39617,
        imageUrl: "https://cdn.myanimelist.net/images/anime/1815/110626.jpg?s=1485b2d6d4bd31622917e954db1dc9f2",
        title: "Yakusoku no Neverland 2nd Season",
        rank: 1,
        startDate: "Jan 2021",
        endDate: nil,
        type: "TV",
        url: "https://myanimelist.net/anime/39617/Yakusoku_no_Neverland_2nd_Season")
}

func getDummyContentTableViewCellViewModel() -> ContentTableViewCellViewModel {
    ContentTableViewCellViewModel(model: getDummyTopModel(), delegate: nil)
}
