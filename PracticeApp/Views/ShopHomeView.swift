//
//  ShopHomeView.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/7.
//

import SwiftUI

struct ShopHomeView: View {
    @StateObject var vm = ShopHomeViewModel()
    
    var body: some View {
        ZStack {
            Color.shopBlack.ignoresSafeArea(edges: .all)
            
            if vm.isLoading {
                ProgressView()
            }
            
            if let error = vm.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.title)
            }
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 20, pinnedViews: [.sectionHeaders], content: {
                    Section{
                        RecentView(products: vm.products)
                        HotProductView(products: vm.products)
                        BrandShowView(productBrands: vm.filterBrand, imageSize: 120)
                    }header: {
                        CategoryView(selectedCategories: $vm.selectedCategory, userImageURL: vm.currentUser?.image, hasProducts: !vm.products.isEmpty)
                            .padding(.leading, 8)
                    }
                })
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
        }
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await vm.loadData()
        }
    }
}

#Preview {
    NavigationStack {
        ShopHomeView()
    }
}
