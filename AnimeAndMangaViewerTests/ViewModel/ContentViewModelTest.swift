//
//  ContentViewModelTest.swift
//  AnimeAndMangaViewerTests
//
//  Created by 五加一 on 2020/12/25.
//

import XCTest
@testable import AnimeAndMangaViewer

class ContentViewModelTest: XCTestCase {

    func testNumberOfRow() {
        let viewModel = self.viewModel
        XCTAssertEqual(viewModel.numberOfRow, .zero)
    }

    func testLoadMore() {
        let viewModel = self.viewModel
        viewModel.loadMore(indexPath: IndexPath(row: .zero, section: .zero))
        XCTAssertEqual(viewModel.numberOfRow, 50)
    }

    func testObserveViewState() {
        let viewModel = self.viewModel
        viewModel.loadMore(indexPath: IndexPath(row: .zero, section: .zero))
        var count = Int.zero
        let waitLoadIng = expectation(description: "waitLoadIng")
        let waitLoadDone = expectation(description: "waitLoadDone")
        viewModel.observeViewState = { state in
            if count == .zero {
                XCTAssertEqual(state, ListVcState.loading)
                waitLoadIng.fulfill()
            }
            if count == 1 {
                XCTAssertEqual(state, ListVcState.loadDone)
                waitLoadDone.fulfill()
            }
            count += 1
        }
        wait(for: [waitLoadIng, waitLoadDone], timeout: 3)
    }

    func testRetry() {
        let viewModel = self.viewModel
        viewModel.retry()
        var count = Int.zero
        let waitLoadIng = expectation(description: "waitLoadIng")
        let waitLoadDone = expectation(description: "waitLoadDone")
        viewModel.observeViewState = { state in
            if count == .zero {
                XCTAssertEqual(viewModel.numberOfRow, .zero)
                waitLoadIng.fulfill()
            }
            if count == 1 {
                XCTAssertEqual(viewModel.numberOfRow, 50)
                waitLoadDone.fulfill()
            }
            count += 1
        }
        wait(for: [waitLoadIng, waitLoadDone], timeout: 3)
    }

    func testSubViewModel() {
        let viewModel = self.viewModel
        viewModel.retry()
        var count = Int.zero
        let waitLoadIng = expectation(description: "waitLoadIng")
        let waitLoadDone = expectation(description: "waitLoadDone")
        viewModel.observeViewState = { state in
            if count == .zero {
                XCTAssertEqual(viewModel.numberOfRow, .zero)
                waitLoadIng.fulfill()
            }
            if count == 1 {
                let dummyMViewModel = getDummyContentTableViewCellViewModel()
                let firstViewModel = viewModel.subViewModel(indexPath: IndexPath(row: .zero, section: .zero))
                XCTAssertEqual(dummyMViewModel, firstViewModel)
                waitLoadDone.fulfill()
            }
            count += 1
        }
        wait(for: [waitLoadIng, waitLoadDone], timeout: 3)
    }

    private var viewModel: ContentViewModel {
        let dataSource = DummyApiDataSource()
        let contentModel = ContentModel(type: JikanType.anime, subType: JikanSubtypeAnime.upcoming)
        let repo = ApiRepository(dataSource: dataSource)
        return ContentViewModel(model: contentModel, apiRepo: repo, delegate: nil)
    }
}
