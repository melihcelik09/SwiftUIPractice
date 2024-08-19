//
//  SpotifyHomeView.swift
//  SwiftUIPractice
//
//  Created by Melih on 19.08.2024.
//

import SwiftfulUI
import SwiftUI

struct SpotifyHomeView: View {
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products = [Product]()
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            ScrollView(.vertical) {
                LazyVStack(spacing: .zero, pinnedViews: [.sectionHeaders], content: {
                    Section {
                        VStack(spacing:16) {
                            recentSection
                            if let firstProduct = products.first {
                                newReleaseSection(product: firstProduct)
                            }

                        }.padding(.horizontal, 16)

                        ForEach(0 ..< 20) { _ in
                            Rectangle()
                                .fill(.red)
                                .frame(width: 200, height: 200)
                                .padding(.vertical)
                        }
                    } header: {
                        header
                    }

                }).padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()

        }.task {
            await getData()
        }.toolbar(.hidden, for: .navigationBar)
    }

    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func newReleaseSection(product: Product) -> some View{
        SpotifyNewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category,
            title: product.title,
            subtitle: product.description,
            onAddToPlaylistPressed: {},
            onPlayPressed: {}
        )
    }

    private var recentSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                SpotifyRecentsCell(
                    imageName: product.firstImage,
                    title: product.title
                )
            }
        }
    }

    private var header: some View {
        HStack(spacing: .zero) {
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .frame(width: 30, height: 30)
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {}
                }
            }.frame(width: 30, height: 30)
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelected: category == selectedCategory
                        ).onTapGesture {
                            selectedCategory = category
                        }
                    }
                }.padding(.horizontal, 16)
            }.scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(.spotifyBlack)
    }
}

#Preview {
    SpotifyHomeView()
}
