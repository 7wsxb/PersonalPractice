//
//  BrandShowView.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/14.
//

import SwiftUI

struct BrandShowView: View {
    
    let productBrands: [BrandGroup]
    let imageSize: CGFloat
    
    var body: some View {
        ForEach(productBrands) { row in
            VStack {
                Text(row.title)
                    .foregroundStyle(.shopLightGray)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(row.products) { product in
                            NavigationLink(destination: DetailInformationView(product: product)) {
                                VStack {
                                    ImageLoaderView(imageURL: product.firstImage)
                                        .frame(width: imageSize, height: imageSize)
                                        .background(Color.shopDarkGary)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    Text(product.title)
                                        .foregroundStyle(.shopLightGray)
                                        .font(.caption)
                                        .frame(width: imageSize, alignment: .center)
                                        .lineLimit(2)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}



#Preview {
    ZStack {
        Color.shopBlack.edgesIgnoringSafeArea(.all)
        
    }
}
