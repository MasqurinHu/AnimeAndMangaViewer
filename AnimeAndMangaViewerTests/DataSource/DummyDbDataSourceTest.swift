//
//  DummyDbDataSourceTest.swift
//  AnimeAndMangaViewerTests
//
//  Created by 五加一 on 2020/12/25.
//

import XCTest
@testable import AnimeAndMangaViewer

class DummyDbDataSourceTest: XCTestCase {

    func testFetchEmpty() {
        let db = DummyDbDataSource()
        XCTAssert(!db.fetchFavorite(model: getDummyTopModel()))
    }

    func testSetAndFetch() {
        let db = DummyDbDataSource()
        let waitSetData = expectation(description: "set data")
        db.setFavorite(true, model: getDummyTopModel()) { result in
            switch result {
            case .success(let isFavorite):
                XCTAssert(isFavorite)
            case .failure(_):
                break
            }
            waitSetData.fulfill()
        }
        wait(for: [waitSetData], timeout: 3)
    }

    func testSetAndFetch2() {
        let db = DummyDbDataSource()
        let waitSetData = expectation(description: "set data")
        db.setFavorite(false, model: getDummyTopModel()) { [weak self] result in
            switch result {
            case .success(let isFavorite):
                XCTAssert(!isFavorite)
                guard let self = self else { return }
                let waitSetData = self.expectation(description: "set data")
                db.setFavorite(true, model: getDummyTopModel()) { result in
                    switch result {
                    case .success(let isFavorite):
                        XCTAssert(isFavorite)
                    case .failure(_):
                        break
                    }
                    waitSetData.fulfill()
                }
                self.wait(for: [waitSetData], timeout: 3)
            case .failure(_):
                break
            }
            waitSetData.fulfill()
        }
        wait(for: [waitSetData], timeout: 3)
    }


}
