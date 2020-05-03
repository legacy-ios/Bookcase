//
//  Book.swift
//  Bookcase
//
//  Created by jungwooram on 2020-04-29.
//  Copyright © 2020 jungwooram. All rights reserved.
//

import Foundation

struct Book: Decodable {
    let title: String
    let author: String
    let narrator: String
    let coverUrl: String
    let query: String
    let nextPageToken: String
}
