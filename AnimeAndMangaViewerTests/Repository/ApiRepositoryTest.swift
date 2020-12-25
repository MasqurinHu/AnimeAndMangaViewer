//
//  ApiRepositoryTest.swift
//  AnimeAndMangaViewerTests
//
//  Created by 五加一 on 2020/12/25.
//

import XCTest
@testable import AnimeAndMangaViewer

class ApiRepositoryTest: XCTestCase {

    func testFetchTop() {
        let dataSource = DummyApiDataSource()
        let contentModel = ContentModel(type: JikanType.anime, subType: JikanSubtypeAnime.upcoming)
        let repo = ApiRepository(dataSource: dataSource)
        let waitGatData = expectation(description: "Get data")
        repo.fetchTop(model: contentModel,page: 1) { result in
            switch result {
            case .success(let model):
                guard let firstModel = model.first else { break }
                XCTAssertEqual(getDummyTopModel(), firstModel)
            case .failure(_):
                break
            }
            waitGatData.fulfill()
        }
        wait(for: [waitGatData], timeout: 3)
    }
}
