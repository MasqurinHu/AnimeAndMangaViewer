//
//  ContentViewModel.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/24.
//

import Foundation

class ContentViewModel {
    private let model: ContentModel
    private weak var delegate: ContentTableViewCellViewModelDelegate?
    private let repo: ApiRepository
    private var data: [TopModel] = []
    private var isLoading: LoadState = LoadState.normal
    private var retryIndex: Int?

    var observeViewState:((ListVcState) -> ())? {
        didSet {
            reset()
            loadData(page: startIndex)
        }
    }

    init(model: ContentModel,
         apiRepo: ApiRepository,
         delegate: ContentTableViewCellViewModelDelegate?) {
        self.model = model
        self.repo = apiRepo
        self.delegate = delegate
    }
}

extension ContentViewModel {
    var numberOfRow: Int { data.count }

    func loadMore(indexPath: IndexPath) {
        let nextPartial = (indexPath.row / offset) + 2
        guard
            isLoading == .normal,
            nextPartial > data.count / offset
        else { return }
        if data.count == .zero {
            loadData(page: startIndex)
        } else {
            loadData(page: nextPartial)
        }
    }

    func retry() {
        guard let retryIndex = retryIndex else { return }
        loadData(page: retryIndex)
    }

    func subViewModel(indexPath: IndexPath) -> ContentTableViewCellViewModel {
        guard data.count > indexPath.row else {
            return ContentTableViewCellViewModel(model: TopModel.dummyModel, delegate: delegate)
        }
        return ContentTableViewCellViewModel(model: data[indexPath.row], delegate: delegate)
    }
}

private extension ContentViewModel {
    var offset: Int { 50 }
    var startIndex: Int { 1 }

    enum LoadState {
        case normal, loading, finish
    }

    func reset() {
        data = []
    }

    func loadData(page: Int) {
        observeViewState?(ListVcState.loading)
        isLoading = LoadState.loading
        repo.fetchTop(model: model, page: page) { [weak self] result in
            self?.isLoading = LoadState.normal
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.retryIndex = nil
                self.data += data
                self.observeViewState?(ListVcState.loadDone)
                if Float(data.count).truncatingRemainder(dividingBy: Float(self.offset)) != 0 {
                    self.isLoading = LoadState.finish
                }
            case .failure(let error):
                self.retryIndex = page
                self.observeViewState?(ListVcState.loadFail(error.localizedDescription))
            }
            self.isLoading = LoadState.normal
        }
    }
}
