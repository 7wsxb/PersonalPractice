//
//  ProductRepository.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/23.
//

import Foundation
import Combine

struct ProductRepository: ProductRepositoryProtocol {
    private let baseURL: String
    
    init(baseURL: String = "https://dummyjson.com") {
        self.baseURL = baseURL
    }
    
    func getProducts() -> AnyPublisher<[Product], Error> {
        guard let url = URL(string: "\(baseURL)/products") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ProductArray.self, decoder: JSONDecoder())
            .map(\.products)
            .eraseToAnyPublisher()
    }
}

// MARK: - Async/await backward compatibility
extension ProductRepository {
    func getProducts() async throws -> [Product] {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            cancellable = getProducts()
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
