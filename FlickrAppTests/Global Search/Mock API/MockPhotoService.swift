//
//  MockPhotoService.swift
//  FlickrApp
//
//  Created by Patel, Viren on 3/14/25.
//

import XCTest
@testable import FlickrApp

class MockPhotoService: PhotoServiceProtocol {
    var result: Result<[Photo], Error>?

    func fetchPhotos(searchQuery: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
