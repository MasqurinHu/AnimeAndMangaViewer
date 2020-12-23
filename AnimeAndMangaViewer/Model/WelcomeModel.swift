//
//  Welcome.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/23.
//

import Foundation

protocol ModelSpec: Codable {}
protocol TopModelSpec: ModelSpec {}

// MARK: - Welcome
struct Welcome<Top: TopModelSpec>: ModelSpec {
    let requestHash: String
    let requestCached: Bool
    let requestCacheExpiry: Int
    let top: [Top]
}
