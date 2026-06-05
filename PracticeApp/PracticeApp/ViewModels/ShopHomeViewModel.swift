//
//  ShopHomeViewModel.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/17.
//

import Foundation

class ShopHomeViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var currentUser: User?
    @Published var selectedCategory: Category? = .all
    
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    ///两个计算属性，将category放入顶层数据以筛选product
    var filteredProducts: [Product] {
        guard let selectedCategory, selectedCategory != .all else { return products }
        return products.filter({$0.category == selectedCategory})
    }
    
    var filterBrand: [BrandGroup] {
        productService.groupByBrand(filteredProducts)
    }
    
    private let productService: ProductService
    private let userService: UserService
    
    init(
        productService: ProductService = ProductService(),
        userService: UserService = UserService()
    ) {
        self.productService = productService
        self.userService = userService
    }
    
    @MainActor
    func loadData() async {
        isLoading = true
        errorMessage = nil
        do {
            async let fetchedProducts = productService.loadProducts()
            async let fetchedUser = userService.loadCurrentUser()
            
            self.products = try await fetchedProducts
            self.currentUser = try await fetchedUser
        } catch {
            errorMessage = "加载失败：\(error.localizedDescription)"
            print("Load Data Error: \(error)")
        }
        isLoading = false
    }
    
    func updateCurrentUser(_ user: User) {
        // 先在主线程上捕获需要的依赖
        let service = userService
        Task {
            try? await service.updateUser(user)
            await MainActor.run { [weak self] in
                self?.currentUser = user
            }
        }
    }
}
