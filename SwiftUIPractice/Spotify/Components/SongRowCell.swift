//
//  SongRowCell.swift
//  SwiftUIPractice
//
//  Created by Melih on 22.08.2024.
//

import SwiftUI

struct SongRowCell: View {
    var imageSize: CGFloat = 50
    var lineLimit: Int = 2
    var imageUrl: String = Constants.randomImage
    var title: String? = Product.mock.title
    var description: String? = Product.mock.description
    var onCellPressed: (()-> Void)? = nil
    var onEllipsisPressed: (()-> Void)? = nil
    var body: some View {
        HStack(spacing:8){
            ImageLoaderView(urlString: imageUrl)
                .frame(width: imageSize,height: imageSize)
            VStack(alignment:.leading,spacing:4){
                Text(title ?? "")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.spotifyWhite)
                Text(description ?? "")
                    .font(.callout)
                    .foregroundStyle(.spotifyLightGray)
            }
            .lineLimit(lineLimit)
            .frame(maxWidth: .infinity,alignment: .leading)
            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundStyle(.spotifyWhite)
                .padding(16)
                .onTapGesture {
                    onEllipsisPressed?()
                }
        }
        .background(.black.opacity(0.001))
        .onTapGesture {
            onCellPressed?()
        }
    }
}

#Preview {
    ZStack{
        Color.spotifyBlack.ignoresSafeArea()
        VStack{
            SongRowCell()
            SongRowCell()
            SongRowCell()
        }
      
    }

}
