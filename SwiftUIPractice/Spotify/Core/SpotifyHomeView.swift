//
//  SpotifyHomeView.swift
//  SwiftUIPractice
//
//  Created by Melih on 19.08.2024.
//

import SwiftfulUI
import SwiftfulRouting
import SwiftUI



struct SpotifyHomeView: View {
        
    @State var viewModel: SpotifyHomeViewModel
    @Environment(\.router) var router


    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            ScrollView(.vertical) {
                LazyVStack(spacing: .zero, pinnedViews: [.sectionHeaders], content: {
                    Section {
                        VStack(spacing: 16) {
                            recentSection
                                .padding(.horizontal, 16)
                            if let firstProduct = viewModel.products.first {
                                newReleaseSection(product: firstProduct)
                                    .padding(.horizontal, 16)
                            }
                            categoryListSection
                        }
                    } header: {
                        header
                    }

                }).padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()

        }.task {
            await viewModel.getData()
        }.toolbar(.hidden, for: .navigationBar)
    }

    private var categoryListSection: some View {
        ForEach(viewModel.productRows) { row in
            VStack(spacing: 8) {
                Text(row.title.capitalized)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(
                                imageSize: 120,
                                imageName: product.image ?? "",
                                title: product.title ?? ""
                            )
                            .background(.black.opacity(0.001))
                            .asButton(.press) {
                                goToPlaylistView(product: product)
                            }
                        }
                    }.padding(.horizontal, 16)
                }.scrollIndicators(.hidden)
            }
        }
    }

    private func newReleaseSection(product: Product) -> some View {
        SpotifyNewReleaseCell(
            imageName: product.image ?? "",
            headline: product.category?.rawValue.capitalized,
            subheadline: "\(product.rating?.rate ?? 0) Point - \(product.rating?.count ?? 0) Comment",
            title: product.title,
            subtitle: product.description,
            onAddToPlaylistPressed: {},
            onPlayPressed: {}
        )
    }

    private var recentSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: viewModel.products) { product in
            if let product {
                SpotifyRecentsCell(
                    imageName: product.image ?? "",
                    title: product.title ?? ""
                ).asButton(.press) {
                    goToPlaylistView(product: product)
                }
            }
        }
    }
    
    private func goToPlaylistView(product: Product){
        guard let currentUser = viewModel.currentUser else {return}
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product, user: currentUser)
        }
    }

    private var header: some View {
        HStack(spacing: .zero) {
            ZStack {
                if viewModel.currentUser != nil {
                    ImageLoaderView()
                        .frame(width: 30, height: 30)
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            router.dismissScreen()
                        }
                }
            }.frame(width: 30, height: 30)
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelected: category == viewModel.selectedCategory
                        ).onTapGesture {
                            viewModel.selectedCategory = category
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
    RouterView { router in
        SpotifyHomeView(viewModel: SpotifyHomeViewModel(router:router))
    }
}
