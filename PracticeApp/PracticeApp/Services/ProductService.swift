//
//  ProductService.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/24.
//

import Foundation
import Combine

struct ProductService {
    
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol = ProductRepository()) {
        self.repository = repository
    }
    
    func loadProducts() -> AnyPublisher<[Product], Error> {
        repository.getProducts()
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

// MARK: - Async/await backward compatibility
extension ProductService {
    func loadProducts() async throws -> [Product] {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            cancellable = loadProducts()
                .sink(
                    receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            continuation.resume(throwing: error)
                        }
                        _ = cancellable
                    },
                    receiveValue: { products in
                        continuation.resume(returning: products)
                        _ = cancellable
                    }
                )
        }
    }
}
