//
//  RecentCellView.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/10.
//

import SwiftUI

struct RecentCellView: View {
    
    var imageURL: String? = nil
    var title: String = "May Be You Like It."
    
    var body: some View {
        HStack(){
            ImageLoaderView(imageURL: imageURL ?? "")
                .frame(width: 56, height: 56)
            
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .lineLimit(2)
        }
        .frame(minWidth: 200, alignment: .leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        .themeColor(isSelected: false)
        .cornerRadius(6)
    }
}

#Preview {
    RecentCellView(imageURL: "https://dummyjson.com/icon/abc123/150")
}
