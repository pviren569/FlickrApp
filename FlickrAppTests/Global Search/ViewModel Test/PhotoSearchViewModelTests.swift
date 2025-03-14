//
//  PhotoSearchViewModelTests.swift
//  PhotoSearchViewModelTests
//
//  Created by Patel, Viren on 3/13/25.
//

import XCTest
@testable import FlickrApp

final class PhotoSearchViewModelTests: XCTestCase {

    var viewModel: PhotoSearchViewModel!
    var mockService: MockPhotoService!

    override func setUp() {
        super.setUp()
        mockService = MockPhotoService()
        viewModel = PhotoSearchViewModel(photoService: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    // Valid Response
    func testFetchPhotos_ValidResponse() {
        let mockPhotos = [
            Photo(title: "Test Photo", media: Media(imageUrl: "https://example.com/image.jpg"), publishedDate: "2025-03-13T20:08:45Z", description: "Test Description", author: "Test Author")
        ]
        mockService.result = .success(mockPhotos)

        viewModel.searchQuery = "Test"
        viewModel.fetchPhotos()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.photoVMs.count, 1)
            XCTAssertEqual(self.viewModel.photoVMs.first?.title, "Test Photo")
        }
    }

    // Empty response
    func testFetchPhotos_EmptyResponse() {
        mockService.result = .success([])

        viewModel.searchQuery = "Test"
        viewModel.fetchPhotos()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.photoVMs.count, 0)
            XCTAssertEqual(self.viewModel.errorMessage, "No result Found. Please try another keyword.")
        }
    }

    // Network Error
    func testFetchPhotos_APIError() {
        let error = NSError(domain: "NetworkError", code: 1, userInfo: nil)
        mockService.result = .failure(error)

        viewModel.searchQuery = "Test"
        viewModel.fetchPhotos()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.errorMessage)
            XCTAssertEqual(self.viewModel.photoVMs.count, 0)
        }
    }

    // Empty SearchQuery
    func testFetchPhotos_EmptySearchQuery() {
        viewModel.searchQuery = ""
        viewModel.fetchPhotos()

        XCTAssertEqual(viewModel.photoVMs.count, 0)
    }
}
