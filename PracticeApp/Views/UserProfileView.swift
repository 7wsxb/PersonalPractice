//
//  UserProfileView.swift
//  PracticeApp
//
//  Created by Wang on 2026/5/18.
//

import SwiftUI
import SDWebImage

struct UserProfileView: View {
    let avatarSize: CGFloat = 100

    var body: some View {
        ZStack {
            Color.shopBlack.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    ZStack(alignment: .center) {
                        ImageLoaderView()
                            .frame(maxWidth: .infinity)
                            .scaledToFit()
                            .background(.shopDarkGary)
                            .opacity(0.25)

                        VStack(spacing: 8) {
                            ImageLoaderView()
                                .frame(width: avatarSize, height: avatarSize)
                                .background(.shopDarkGary)
                                .clipShape(Circle())

                            Text("username")
                                .font(.title2)
                                .foregroundStyle(.shopLightGray)

                            Text("aaaaaa\naaaaa\naaaaa\naaaaa")
                                .font(.subheadline)
                                .foregroundStyle(.shopGary)
                        }
                        .alignmentGuide(VerticalAlignment.center) { d in
                            avatarSize / 2
                        }
                    }

                }
            }
        }
    }
}
#Preview {
    UserProfileView()
}
