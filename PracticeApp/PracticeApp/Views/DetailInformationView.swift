//
//  DetailInformationView.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/13.
//

import SwiftUI

struct DetailInformationView: View {
    
    let product: Product
    
    var body: some View {
        ZStack {
            Color.shopBlack.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 17) {
                    ImageLoaderView(imageURL: product.firstImage)
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(.shopWhite)
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text(product.title)
                            .font(.title3)
                        HStack {
                            Text(product.brand ?? "NO BRAND")
                            Spacer()
                            Text("PRICE: $\(product.price)")
                                .foregroundStyle(.shopGreen)
                        }
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(7)
                    .foregroundStyle(.shopWhite)
                    .background(.shopGary)
                    .cornerRadius(10)
                    
                    Text("      \(product.description)")
                        .font(.headline)
                        .foregroundStyle(.shopWhite)
                        .padding(3)
                }
                .background(.shopBlack).ignoresSafeArea(.keyboard)
            }
        }
    }
}

#Preview {
//    DetailInformationView()
}
