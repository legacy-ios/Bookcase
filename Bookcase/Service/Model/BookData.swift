//
//  BookData.swift
//  Bookcase
//
//  Created by jungwooram on 2020-04-29.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import Foundation

struct BookData: Codable {
    let query: String
    let nextPageToken: String
    let items: [Item]
}

struct Item: Codable {
    let title: String
    let authors, narrators: [Common]
    let cover: Cover
    
    enum CodingKeys: String, CodingKey {
        case title, authors, narrators, cover
    }
}

struct Common: Codable {
    let id, name: String
}

struct Cover: Codable {
    let url: String
    let width, height: Int
}


