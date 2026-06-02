//
//  ProductService.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/24.
//

import Foundation

struct ProductService {
    
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol = ProductRepository()) {
        self.repository = repository
    }
    
    func loadProducts() async throws -> [Product] {
        try await repository.getProducts()
    }
    
    func groupByBrand(_ products: [Product]) -> [BrandGroup] {
        let group = Dictionary(grouping: products) { $0.brand }
        let noBrand = UIString.noBrand
        let rows = group.map {brand, products in
            BrandGroup(title: brand?.capitalized ?? noBrand, products: products)
        }
        return rows.sorted { $0.title != noBrand && $1.title == noBrand }
    }
}
