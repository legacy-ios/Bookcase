//
//  BookData.swift
//  Bookcase
//
//  Created by jungwooram on 2020-04-29.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import Foundation

// MARK: - BookData
struct BookData: Codable {
    let nextPageToken: String
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let authors, narrators: [Common]
    let cover: Cover
    
    enum CodingKeys: String, CodingKey {
        case title, authors, narrators, cover
    }
}

// MARK: - Common
struct Common: Codable {
    let id, name: String
}

// MARK: - Cover
struct Cover: Codable {
    let url: String
    let width, height: Int
}


