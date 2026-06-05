//
//  HotProductViewModel.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/16.
//

import Foundation

class HotProductViewModel: ObservableObject {
    
    @Published var currentProductIndex: Int = 0
    @Published var currentImageIndex: Int = 0
    
    private var products: [Product] = []
    
    var currentProduct: Product? {
        guard products.indices.contains(currentProductIndex) else { return nil }
        return products[currentProductIndex]
    }
    
    var currentImageURL: String {
        guard let product = currentProduct,
              !product.images.isEmpty,
              product.images.indices.contains(currentImageIndex)
        else {
            return Constants.randomImage
        }
        return product.images[currentImageIndex]
    }
    
    var hasMultipleImages: Bool {
        (currentProduct?.images.count ?? 0) > 1
    }
    
    func configure(with newProducts: [Product]) {
        products = newProducts
        currentProductIndex = 0
        currentImageIndex = 0
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
