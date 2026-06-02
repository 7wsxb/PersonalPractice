//
//  ProductRepository.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/23.
//

import Foundation

struct ProductRepository: ProductRepositoryProtocol {
    private let baseURL: String
    
    init(baseURL: String = "https://dummyjson.com") {
        self.baseURL = baseURL
    }
    
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: ("\(baseURL)/products")) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ProductArray.self, from: data)
        return response.products
    }
}
