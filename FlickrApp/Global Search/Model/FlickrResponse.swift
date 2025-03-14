//
//  FlickrResponse.swift
//  FlickrApp
//
//  Created by Patel, Viren on 3/13/25.
//

import Foundation

struct FlickrResponse: Codable {
    let items: [Photo]
}

struct Photo: Codable {
    let title: String
    let media: Media
    let publishedDate: String
    let description: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case title, media, author, description
        case publishedDate = "published"
    }
}

struct Media: Codable {
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "m"
    }
}
