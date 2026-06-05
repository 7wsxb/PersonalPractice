//
//  RecentView.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/12.
//

import SwiftUI
import SwiftfulUI

struct RecentView: View {
    
    let products: [Product]
    
    var body: some View {
        VStack {
            let products = Array(products.prefix(8))
            NonLazyVGrid(columns: 2, alignment: .center, spacing: 8, items: products) { product in
                if let product = product {
                    NavigationLink(destination: DetailInformationView(product: product)) {
                        RecentCellView(
                            imageURL: product.firstImage,
                            title: product.title)
                    }
                }
            }
        }
    }
}

#Preview {
//    RecentView()
}
