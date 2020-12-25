//
//  ApiDataSourceTest.swift
//  AnimeAndMangaViewerTests
//
//  Created by 五加一 on 2020/12/25.
//

import XCTest
@testable import AnimeAndMangaViewer

class ApiDataSourceTest: XCTestCase {

    func testDummyDataSource() {
        let contentModel = ContentModel(type: JikanType.anime, subType: JikanSubtypeAnime.upcoming)
        let waitGatData = expectation(description: "Get data")
        DummyApiDataSource().fetchTop(model: contentModel, page: 1, doneHandle: { dummyResult in
            ApiDataSource().fetchTop(model: contentModel, page: 1, doneHandle: { result in
                switch dummyResult {
                case .success(let dummyData):
                    switch result {
                    case .success(let data):
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        guard
                            let dummyModel = try? decoder.decode(Welcome<TopModel>.self, from: dummyData),
                            let model = try? decoder.decode(Welcome<TopModel>.self, from: data)
                        else { break }
                        XCTAssertEqual(dummyModel, model)
                    case .failure(_):
                        break
                    }
                    waitGatData.fulfill()
                case .failure(_):
                    waitGatData.fulfill()
                }
            })
        })
        wait(for: [waitGatData], timeout: 3)
    }
}
