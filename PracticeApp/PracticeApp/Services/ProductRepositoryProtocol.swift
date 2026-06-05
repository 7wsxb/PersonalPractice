//
//  ProductRepositoryProtocol.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/23.
//

import Foundation
import Combine

protocol ProductRepositoryProtocol {
    func getProducts() async throws -> [Product]
    func getProducts() -> AnyPublisher<[Product], Error>
}
