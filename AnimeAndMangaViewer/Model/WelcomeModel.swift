//
//  Welcome.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/23.
//

import Foundation

struct Welcome<T: Decodable & Equatable>: Decodable {
    let requestHash: String
    let requestCached: Bool
    let requestCacheExpiry: Int
    let top: [T]
}

extension Welcome: Equatable {
    static func == (lhs: Welcome<T>, rhs: Welcome<T>) -> Bool {
        lhs.top == rhs.top
    }
}
