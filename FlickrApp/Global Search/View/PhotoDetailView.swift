//
//  PhotoDetailView.swift
//  FlickrApp
//
//  Created by Patel, Viren on 3/13/25.
//

import SwiftUI

struct PhotoDetailView: View {
    
    @ObservedObject var vm: PhotoViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            imageView
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .accessibilityLabel("Photo of \(vm.title)")
            
            titleView
                
            authorView
                
            publishedDateView
                
            descriptionView
            
            Spacer()
        }
        .padding()
        .onAppear(perform: vm.loadImage)
    }
    
    @ViewBuilder
    var imageView: some View {
        if let image = vm.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else {
            // Should not come here since image is already loaded PhotoViewModel from Previous view. but keeping the code here just in case.
            AsyncImage(url: vm.url) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
        }
    }
    
    var titleView: some View {
        Text(vm.title)
            .font(.headline)
            .accessibilityLabel("Title: \(vm.title)")
    }
    
    var authorView: some View {
        Text("By: " + vm.author)
            .font(.subheadline)
            .accessibilityLabel("Author: \(vm.author)")
    }
    
    var publishedDateView: some View {
        Text("Published: " + vm.publishedDate)
            .font(.caption)
            .foregroundColor(.gray)
            .accessibilityLabel("Published date: \(vm.publishedDate)")
    }
    
    var descriptionView: some View {
        Text(vm.formattedDescription)
            .font(.body)
    }
}
