//
//  PhotoService.swift
//  FlickrApp
//
//  Created by Patel, Viren on 3/13/25.
//

import Foundation

protocol PhotoServiceProtocol {
    func fetchPhotos(searchQuery: String, completion: @escaping (Result<[Photo], Error>) -> Void)
}

class PhotoService: PhotoServiceProtocol {
    private let baseURL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="
    
    func fetchPhotos(searchQuery: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard !searchQuery.isEmpty else {
            completion(.success([]))
            return
        }
        
        let urlString = baseURL + (searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 204, userInfo: nil)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(FlickrResponse.self, from: data)
                completion(.success(response.items))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
