//
//  SubTypeViewModel.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/24.
//

import Foundation

class SubTypeViewModel {
    let topType: JikanType

    init(type: JikanType) {
        topType = type
    }
}

extension SubTypeViewModel {
    var numberOfSubType: Int {
        switch topType {
        case .anime:
            return JikanSubtypeAnime.allCases.count
        case .manga:
            return JikanSubtypeManga.allCases.count
        }
    }

    func subTypeTitle(indexPath: IndexPath) -> String {
        let titleList: [String]
        switch topType {
        case .anime:
            titleList = JikanSubtypeAnime.allCases.map { $0.rawValue }
        case .manga:
            titleList = JikanSubtypeManga.allCases.map { $0.rawValue }
        }
        guard titleList.count > indexPath.row else { return "" }
        return titleList[indexPath.row]
    }

    func getContentModel(indexPath: IndexPath) -> ContentModel? {
        let pathList: [PathType]
        switch topType {
        case .anime:
            pathList = JikanSubtypeAnime.allCases.map { $0 }
        case .manga:
            pathList = JikanSubtypeManga.allCases.map { $0 }
        }
        guard pathList.count > indexPath.row else { return nil }
        return ContentModel(type: topType, subType: pathList[indexPath.row])
    }
}
