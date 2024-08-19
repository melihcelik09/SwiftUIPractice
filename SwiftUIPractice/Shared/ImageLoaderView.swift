//
//  ImageLoaderView.swift
//  SwiftUIPractice
//
//  Created by Melih on 19.08.2024.
//

import SDWebImageSwiftUI
import SwiftUI

struct ImageLoaderView: View {
    var urlString: String = Constants.randomImage
    var resizingMode: ContentMode = .fill

    var body: some View {
        Rectangle()
            .opacity(.zero)
            .overlay {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
                    .allowsHitTesting(false)
            }.clipped()
    }
}

#Preview {
    ImageLoaderView()
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(40)
        .padding(.vertical, 60)
}
