//
//  PlaylistHeaderCell.swift
//  SwiftUIPractice
//
//  Created by Melih on 21.08.2024.
//

import SwiftUI
import SwiftfulUI

struct PlaylistHeaderCell: View {
    var height: CGFloat = 300
    var title: String = "Some playlist title"
    var subtitle: String = "Some playlist subtitle"
    var imageName: String = Constants.randomImage
    var shadowColor: Color = .spotifyBlack.opacity(0.8)
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
                ImageLoaderView(urlString: imageName)
            )
            .overlay(alignment:.bottomLeading,
                     content: {
                VStack(alignment: .leading,
                       spacing: 8,
                       content: {
                    Text(subtitle)
                        .font(.headline)
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                })
                .foregroundStyle(.spotifyWhite)
                .padding(16)
                .frame(maxWidth:.infinity,alignment: .leading)
                .background(
                    LinearGradient(
                        colors: [
                            .clear,
                            shadowColor
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            })
            .asStretchyHeader(startingHeight:height)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ScrollView {
            PlaylistHeaderCell()
        }.ignoresSafeArea()
    }
}
