//
//  ContentTableViewCellViewModelTest.swift
//  AnimeAndMangaViewerTests
//
//  Created by 五加一 on 2020/12/25.
//

import XCTest
@testable import AnimeAndMangaViewer

class ContentTableViewCellViewModelTest: XCTestCase {

    func testFavoriteAction() {
        let repo = DbRepository(dataSource: DummyDbDataSource())
        let viewModel = ContentTableViewCellViewModel(model: getDummyTopModel(), dbRepo: repo, delegate: nil)
        var count = Int.zero
        viewModel.isFavorite = { isFavorite in
            if count == .zero {
                XCTAssert(!isFavorite)
            }
            if count == 1 {
                XCTAssert(isFavorite)
            }
            if count == 2 {
                XCTAssert(!isFavorite)
            }
            count += 1
        }
        viewModel.favoriteAction()
        viewModel.favoriteAction()
    }
}
