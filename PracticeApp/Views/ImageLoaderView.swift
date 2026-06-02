//
//  ImageLoaderView.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/6.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    
    var contentMode: ContentMode = .fit
    var imageURL: String = "https://dummyjson.com/icon/abc123/150"
    
    var body: some View {
        WebImage(url: URL(string: imageURL))
            .resizable()
            .indicator(.activity )
            .aspectRatio(contentMode: contentMode)
    }
}

#Preview {
    ImageLoaderView()
}
