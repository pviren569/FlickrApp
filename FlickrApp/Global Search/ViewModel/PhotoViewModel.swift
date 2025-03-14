//
//  PhotoViewModel.swift
//  FlickrApp
//
//  Created by Patel, Viren on 3/13/25.
//

import SwiftUI

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

class PhotoViewModel: ObservableObject, Identifiable {
    let id = UUID()
    @Published var image: UIImage? = nil
    private let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    func loadImage() {
        guard let url = url else { return }
        
        if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let uiImage = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                ImageCache.shared.setObject(uiImage, forKey: url.absoluteString as NSString)
                self.image = uiImage
            }
        }.resume()
    }
    
    var url: URL? {
        URL(string: photo.media.imageUrl)
    }
    
    var title: String {
        photo.title
    }
    
    var author: String {
        photo.author
    }
    
    var publishedDate: String {
        photo.publishedDate.formatReadbleDate ?? ""
    }
    
    var formattedDescription: AttributedString {
        return photo.description.htmlToAttributedString ?? AttributedString("No description available")
    }
}

extension PhotoViewModel: Hashable {
    static func == (lhs: PhotoViewModel, rhs: PhotoViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
