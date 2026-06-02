//
//  Products.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/6.
//

import Foundation

// MARK: - ProductArray
struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable, Identifiable, Equatable{
    let id: Int
    let title, description: String
    let price: Double
    let stock: Int
    let brand: String?
    let weight: Int
    let minimumOrderQuantity: Int
    let images: [String]
    let category: Category
    
    var firstImage: String { images.first ?? Constants.randomImage }
}


enum Category: String, CaseIterable, Codable {
    case all
    case beauty = "beauty"
    case fragrances = "fragrances"
    case furniture = "furniture"
    case groceries = "groceries"
}


enum CreatedAt: String, Codable {
    case the20250430T094102053Z = "2025-04-30T09:41:02.053Z"
}



struct BrandGroup: Identifiable {
    var id: String { title }
    let title: String
    let products: [Product]
}
