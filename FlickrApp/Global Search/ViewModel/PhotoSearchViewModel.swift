//
//  PhotoSearchViewModel.swift
//  FlickrApp
//
//  Created by Patel, Viren on 3/13/25.
//

import SwiftUI

class PhotoSearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var photoVMs: [PhotoViewModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let photoService: PhotoServiceProtocol
    
    init(photoService: PhotoServiceProtocol = PhotoService()) {
        self.photoService = photoService
    }
    
    func fetchPhotos() {
        guard !searchQuery.isEmpty else {
            self.photoVMs = []
            return
        }
        
        errorMessage = nil
        self.isLoading = true
        
        photoService.fetchPhotos(searchQuery: searchQuery) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let photos):
                    self.photoVMs = photos.map { PhotoViewModel(photo: $0) }
                    if self.photoVMs.isEmpty {
                        self.errorMessage = "No result Found. Please try another keyword."
                    }
                case .failure(let error):
                    self.errorMessage = "Error fetching photos: \(error.localizedDescription)"
                }
            }
        }
    }
}
