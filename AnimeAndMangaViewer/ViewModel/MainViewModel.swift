//
//  MainViewModel.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/24.
//

import Foundation

class MainViewModel {}

extension MainViewModel {
    var numberOfType: Int { JikanType.allCases.count }
    
    func typeTitle(indexPath: IndexPath) -> String {
        guard indexPath.row < JikanType.allCases.count else { return "" }
        return JikanType.allCases[indexPath.row].rawValue
    }
    
    func getType(indexPath: IndexPath) -> JikanType? {
        guard JikanType.allCases.count > indexPath.row else { return nil }
        return JikanType.allCases[indexPath.row]
    }
}
