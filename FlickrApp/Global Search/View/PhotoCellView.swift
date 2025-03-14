//
//  PhotoCellView.swift
//  FlickrApp
//
//  Created by Patel, Viren on 3/13/25.
//

import SwiftUI

struct PhotoCellView: View {
    @ObservedObject var vm: PhotoViewModel
    
    init(vm: PhotoViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        Group {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: vm.loadImage)
    }
}
