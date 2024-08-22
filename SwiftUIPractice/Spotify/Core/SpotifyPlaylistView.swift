//
//  SpotifyPlaylistView.swift
//  SwiftUIPractice
//
//  Created by Melih on 21.08.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlaylistView: View {
    var product: Product = .mock
    var user: User = .mock
    @State private var products = [Product]()
    @State private var showHeader: Bool = false
    @Environment(\.router) var router
    var body: some View {
        ZStack{
            Color.spotifyBlack.ignoresSafeArea()
            ScrollView(.vertical) {
                LazyVStack(spacing:12){
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title ?? "",
                        subtitle: product.category?.rawValue.capitalized ?? "",
                        imageName: product.image ?? ""
                    ).readingFrame { frame in
                        showHeader = frame.maxY < 150 ? true : false
                    }
                    
                    PlaylistDescriptionCell(
                        description: product.description,
                        username: user.username ?? "",
                        subheadline: product.category?.rawValue.capitalized ?? "",
                        onAddToPlaylistPressed: {},
                        onDownloadPressed:{},
                        onSharePressed:{},
                        onEllipsisPressed:{},
                        onShufflePressed:{},
                        onPlayPressed:{}
                    ).padding(.horizontal,16)
                    
                    ForEach(products) { product in
                        SongRowCell(
                            imageSize: 80,
                            imageUrl: product.image ?? "",
                            title: product.title ?? "",
                            description: product.category?.rawValue.capitalized ?? "",
                            onCellPressed: {
                                goToPlaylistView(product: product)
                            },
                            onEllipsisPressed: {}
                        ).padding(.leading,16)
                    }
                }
            }
            .scrollIndicators(.hidden)
            header
            
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func goToPlaylistView(product: Product){
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product, user: user)
        }
    }

    
    private var header : some View{
        ZStack{
            Text(product.title ?? "")
                .font(.headline)
                .padding(.vertical,20)
                .frame(maxWidth: .infinity)
                .background(.spotifyBlack)
                .offset(y:showHeader ? 0 : -40)
                .opacity(showHeader ? 1 : 0)
            Image(systemName: "chevron.left")
                .font(.title3)
                .padding(10)
                .background(
                    showHeader
                    ? Color.clear
                    : Color.spotifyGray.opacity(0.7)
                )
                .clipShape(Circle())
                .onTapGesture {
                    router.dismissScreen()
                }
                .padding(.leading,16)
                .frame(maxWidth: .infinity,alignment: .leading)
        }
            .foregroundStyle(.spotifyWhite)
            .animation(.smooth(duration: 0.2), value: showHeader)
            .frame(maxHeight: .infinity,alignment: .top)
    }
    
    private func getData() async {
        do {
            products = try await DatabaseHelper().getProducts()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    RouterView { _ in
        SpotifyPlaylistView()
    }
}
