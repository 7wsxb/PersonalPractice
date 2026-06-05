//
//  HotProductView.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/13.
//

import SwiftUI

struct HotProductView: View {
    
    let products: [Product]
    @StateObject private var vm = HotProductViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                ImageLoaderView(imageURL: vm.currentImageURL)
                    .frame(width: 55, height: 55)
                    .background(.shopGary)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    if let product = vm.currentProduct {
                        Text(product.brand ?? "")
                            .font(.callout)
                            .foregroundStyle(.shopLightGray)
                        Text(product.category.rawValue)
                            .font(.title).fontWeight(.heavy)
                            .foregroundStyle(.shopLightGray)
                    }
                }
                Spacer()
                if let product = vm.currentProduct {
                    NavigationLink(destination: DetailInformationView(product: product)) {
                        Image(systemName: "chevron.right.circle.fill")
                            .foregroundStyle(.shopLightGray)
                            .padding(.trailing, 20)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                ImageLoaderView(imageURL: vm.currentImageURL)
                    .frame(width: 150, height: 150)
                    .background(.shopWhite.opacity(0.2))
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    if let product = vm.currentProduct {
                        Text(product.title)
                            .fontWeight(.heavy)
                            .foregroundStyle(.shopLightGray)
                            .lineLimit(1)
                            .padding(.bottom, 10)
                        Text(product.description)
                            .font(.callout)
                            .foregroundStyle(.shopLightGray)
                            .lineLimit(2)
                            .padding(.bottom, 3)
                        HStack {
                            Text("other photos:")
                            Spacer()
                            Image(systemName: "photo.stack")
                                .padding(.trailing, 7)
                                .onTapGesture {
                                    vm.switchToNextImage()
                                }
                        }
                        .foregroundStyle(vm.hasMultipleImages ? Color.shopLightGray : Color.shopGary)
                        HStack {
                            Text("next product:")
                            Spacer()
                            Image(systemName: "chevron.forward.circle")
                                .padding(.trailing, 7)
                                .onTapGesture {
                                    vm.switchToRandomProduct()
                                }
                        }
                        .font(.title3)
                        .foregroundStyle(.shopLightGray)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(5)
            .themeColor(isSelected: false)
            .cornerRadius(10)
        }
        .onAppear {
            vm.configure(with: products)
        }
        .onChange(of: products) { _, newProducts in
            vm.configure(with: newProducts)
        }
    }
}

#Preview {
    ZStack {
        Color.shopBlack.edgesIgnoringSafeArea(.all)
    }
}
