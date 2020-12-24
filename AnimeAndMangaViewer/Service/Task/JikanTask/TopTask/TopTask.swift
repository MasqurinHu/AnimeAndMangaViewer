//
//  TopTask.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/23.
//

struct TopTaskSpec: JikanTaskSpec {
    var endPoint: String
    var httpMethod: HttpMethod

    let type: JikanType
    let page: Int

}

extension TopTaskSpec {
    var reference: String { "/" + JikanReference.top.rawValue }
}
