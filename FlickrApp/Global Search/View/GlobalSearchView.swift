//
//  GlobalSearchView.swift
//  FlickrApp
//
//  Created by Patel, Viren on 3/13/25.
//

import SwiftUI

struct GlobalSearchView: View {
    @StateObject private var viewModel = PhotoSearchViewModel()
    
    var colums: [GridItem] {
        return Array(repeating: GridItem(spacing: 8), count: 2)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                textField
                
                progessOrNoResultView
                
                photosView
            }
            .navigationTitle("Flickr Search")
            .accessibilityLabel("Flickr Search Screen")
        }
    }
    
    var textField: some View {
        TextField("Search Flickr...", text: $viewModel.searchQuery)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .onChange(of: viewModel.searchQuery) { oldValue, newValue in
                if oldValue != newValue {
                    viewModel.fetchPhotos()
                }
            }
            .accessibilityLabel("Search field")
            .accessibilityHint("Enter a keyword to search for images on Flickr")
    }
    
    @ViewBuilder
    var progessOrNoResultView: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
                .accessibilityLabel("Loading images")
        } else if let errorMessage = viewModel.errorMessage, viewModel.photoVMs.isEmpty {
            Text(errorMessage)
                .accessibilityLabel("Error message: \(errorMessage)")
        } else {
            EmptyView()
        }
    }
    
    var photosView: some View {
        ScrollView {
            LazyVGrid(columns: colums) {
                ForEach(viewModel.photoVMs) { photoVM in
                    NavigationLink(destination: PhotoDetailView(vm: photoVM)) {
                        PhotoCellView(vm: photoVM)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .accessibilityLabel("Photo: \(photoVM.title)")
                    }
                }
            }
            .padding(.horizontal, 8)
        }
    }
}
