//
//  JikanTask.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/23.
//

protocol JikanTaskSpec: TaskSpec {
    var reference: String { get }
    var endPoint: String { get }
}

extension JikanTaskSpec {
    var domain: String { "https://private-anon-60bd2f9fda-jikan.apiary-proxy.com" }
    var version: String { "/v3" }
    var url: String { domain + version + reference + endPoint }
}
