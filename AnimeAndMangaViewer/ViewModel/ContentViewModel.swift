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
    private let repo = ApiRepository()
    private var data: [TopModel] = []
    private var isLoading: LoadState = LoadState.normal

    var needReloadData:((ListVcState) -> ())? {
        didSet {
            reset()
            loadData(page: .zero)
        }
    }

    init(model: ContentModel, delegate: ContentTableViewCellViewModelDelegate?) {
        self.model = model
        self.delegate = delegate
    }

    func loadMore(indexPath: IndexPath) {
        let nextPartial = (indexPath.row / offset) + 2
        guard
            isLoading == .normal,
            nextPartial > data.count / offset
        else { return }
        loadData(page: nextPartial)
    }
}

extension ContentViewModel {
    var numberOfRow: Int { data.count }
    var offset: Int { 50 }

    func subViewModel(indexPath: IndexPath) -> ContentTableViewCellViewModel {
        guard data.count > indexPath.row else {
            return ContentTableViewCellViewModel(model: TopModel.dummyModel, delegate: delegate)
        }
        return ContentTableViewCellViewModel(model: data[indexPath.row], delegate: delegate)
    }
}

private extension ContentViewModel {

    enum LoadState {
        case normal, loading, finish
    }

    func reset() {
        data = []
    }

    func loadData(page: Int) {
        needReloadData?(ListVcState.firstLoading)
        isLoading = LoadState.loading
        repo.fetchTop(model: model, page: page) { [weak self] result in
            self?.isLoading = LoadState.normal
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.data += data
                self.needReloadData?(ListVcState.loadDone)
                if Float(data.count).truncatingRemainder(dividingBy: Float(self.offset)) != 0 {
                    self.isLoading = LoadState.finish
                }
            case .failure(let error):
                self.needReloadData?(ListVcState.loadFail(error.localizedDescription))
            }
            self.isLoading = LoadState.normal
        }
    }
}
