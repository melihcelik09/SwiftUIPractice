//
//  ContentView.swift
//  SwiftUIPractice
//
//  Created by Melih on 19.08.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
    @Environment(\.router) var router
    var body: some View {
        List{
            Button("Open Spotify UI") {
                router.showScreen(.fullScreenCover) { router in
                    SpotifyHomeView(
                        viewModel: SpotifyHomeViewModel(
                            router: router
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}
