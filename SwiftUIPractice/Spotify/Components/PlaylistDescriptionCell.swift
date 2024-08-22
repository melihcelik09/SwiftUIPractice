//
//  PlaylistDescriptionCell.swift
//  SwiftUIPractice
//
//  Created by Melih on 21.08.2024.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    var description: String? = Product.mock.description
    var username: String = "Nick"
    var subheadline: String = "Some headline goes here"
    var onAddToPlaylistPressed: (()->Void)? = nil
    var onDownloadPressed: (()->Void)? = nil
    var onSharePressed: (()->Void)? = nil
    var onEllipsisPressed: (()->Void)? = nil
    var onShufflePressed: (()->Void)? = nil
    var onPlayPressed: (()->Void)? = nil
    
    var body: some View {
        VStack(
            alignment:.leading,
            spacing:8
        ){
            Text(description ?? "")
                .foregroundStyle(.spotifyLightGray)
                .frame(maxWidth: .infinity,alignment: .leading)
            madeForYouSection
            Text(subheadline)
            buttonsRow
            
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.spotifyLightGray)
    }
    
    private var buttonsRow: some View{
        HStack(spacing:0){
            HStack(spacing:0){
                Image(systemName: "plus.circle")
                    .padding(8)
                    .onTapGesture {}
                Image(systemName: "arrow.down.circle")
                    .padding(8)
                    .onTapGesture {}
                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .onTapGesture {}
                Image(systemName: "ellipsis")
                    .padding(8)
                    .onTapGesture {}
            }
            .offset(x:-8)
            .frame(maxWidth: .infinity,alignment: .leading)
            
            HStack(spacing:8){
                Image(systemName: "shuffle")
                    .font(.system(size: 24))
                    .padding(8)
                    .onTapGesture {}
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 24))
                    .padding(8)
                    .onTapGesture {}
            }.foregroundStyle(.spotifyGreen)
        }
        .font(.title2)
    }
    
    private var madeForYouSection: some View{
        HStack{
            Image(systemName: "applelogo")
                .font(.title3)
                .foregroundStyle(.spotifyGreen)
            Text("Made for ") + Text(username)
                .fontWeight(.bold)
                .foregroundStyle(.spotifyWhite)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PlaylistDescriptionCell().padding()
    }
}
