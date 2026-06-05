//
//  CategoryView.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/10.
//

import SwiftUI

struct CategoryView: View {
    @Binding var selectedCategories: Category?
    let userImageURL: String?
    let hasProducts: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            if let userImageURL {
                NavigationLink(destination:UserProfileView()) {
                    ImageLoaderView(imageURL: userImageURL)
                        .background(.shopLightGray)
                        .clipShape(Circle())
                        .frame(width:35, height: 35)
                }
            }else {
                Image(systemName: "person.circle.fill")
                    .foregroundColor(.white)
            }
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    if hasProducts {
                        ForEach(Category.allCases, id: \.self) { category in
                            CategoryCellView(
                                titleText: category.rawValue.capitalized,
                                isSelected: selectedCategories == category
                            )
                            .onTapGesture {
                                selectedCategories = category
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(8)
            .scrollIndicators(.hidden)
        }
    }
}


#Preview {
    ZStack {
        Color.shopBlack.ignoresSafeArea(edges: .all)
//        CategoryView()
    }
}
