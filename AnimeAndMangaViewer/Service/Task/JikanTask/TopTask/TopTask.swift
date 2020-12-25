//
//  TopTask.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/23.
//

struct TopTask: JikanTaskSpec {
    let model: ContentModel
    let page: Int
}

extension TopTask {
    var reference: String { "/" + JikanReference.top.rawValue }
    var httpMethod: HttpMethod { .get }
    var endPoint: String { model.type.getPath + "/\(page)" + model.subType.getPath }
}
