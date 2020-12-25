//
//  JikanEnum.swift
//  AnimeAndMangaViewer
//
//  Created by 五加一 on 2020/12/23.
//

enum JikanReference: String {
    case top
}

protocol PathType {
    var getPath: String { get }
}

enum JikanType: String, CaseIterable, PathType {
    case anime , manga

    var getPath: String { "/" + rawValue }
}

enum JikanSubtypeAnime: String, CaseIterable, PathType  {
    case airing, upcoming, tv, movie, ova, special

    var getPath: String { "/" + rawValue }
}

enum JikanSubtypeManga: String, CaseIterable, PathType  {
    case manga, novels, oneshots, doujin, manhwa, manhua

    var getPath: String { "/" + rawValue }
}
