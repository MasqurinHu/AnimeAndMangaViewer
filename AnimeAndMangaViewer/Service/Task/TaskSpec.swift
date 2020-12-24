//
//  TaskSpec.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/23.
//

enum HttpMethod: String {
    case get = "GET"
}

protocol TaskSpec {
    var url: String { get }
    var httpMethod: HttpMethod { get }
}
