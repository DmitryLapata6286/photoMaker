//
//  Models.swift
//  PhotoMaker
//
//  Created by Dmitry Lapata on 23.08.22.
//

import Foundation

struct ListPhotos: Codable {
    let content: [Content]?
    let page, pageSize, totalElements, totalPages: Int?
}

struct Content: Codable {
    let id: Int?
    let name, image: String?
}


