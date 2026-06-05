//
//  CategoryCellView.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/9.
//

import SwiftUI

struct CategoryCellView: View {
    
    var titleText: String = ""
    var isSelected: Bool = false
    
    var body: some View {
        Text(titleText)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .themeColor(isSelected: isSelected)
            .cornerRadius(12)
    }
}

#Preview {
    ZStack {
        Color.shopBlack.ignoresSafeArea(edges: .all)
        
        CategoryCellView(titleText: "Happy King", isSelected: true)
        
    }
}

///themeColor
extension View {
    func themeColor(isSelected: Bool) -> some View {
        self
            .foregroundStyle(isSelected ? Color.shopBlack : Color.shopLightGray)
            .background(isSelected ? Color.shopGreen : Color.shopDarkGary)
    }
}
