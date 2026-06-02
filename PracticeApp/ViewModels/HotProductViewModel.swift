//
//  HotProductViewModel.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/16.
//

import Foundation

class HotProductViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var currentProductIndex: Int = 0
    @Published var currentImageIndex: Int = 0
    
    var currentProduct: Product? {
        guard products.indices.contains(currentProductIndex) else { return nil }
        return products[currentProductIndex]
    }
        
    func switchToNextImage() {
        guard let product = currentProduct, !product.images.isEmpty else { return }
        currentImageIndex = (currentImageIndex + 1) % product.images.count
    }
    
    func switchToRandomProduct() {
        guard !products.isEmpty else { return }
        currentProductIndex = Int.random(in: 0..<products.count)
        currentImageIndex = 0
    }
}
