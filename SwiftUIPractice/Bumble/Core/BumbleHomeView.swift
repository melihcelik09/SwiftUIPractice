//
//  BumbleHomeView.swift
//  SwiftUIPractice
//
//  Created by Melih on 22.08.2024.
//

import SwiftUI

struct BumbleHomeView: View {
    @AppStorage("bumble_home_filter") private var selectedFilter : FilterType = .everyone
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            VStack(spacing:12){
                header
                BumbleFilterView(selection: $selectedFilter)
                    .background(Divider(),alignment: .bottom)
                Spacer()
                BumbleCardView()
            }.padding(8)
        }
    }
}

private var header: some View{
    HStack(spacing:0){
        HStack(spacing:0){
            Image(systemName: "line.horizontal.3")
                .padding(8)
                .background(.black.opacity(0.001))
                .onTapGesture {}
            Image(systemName: "arrow.uturn.left")
                .padding(8)
                .background(.black.opacity(0.001))
                .onTapGesture {}
        }.frame(maxWidth: .infinity,alignment: .leading)
        Text("bumble")
            .font(.title)
            .foregroundStyle(.bumbleYellow)
            .frame(maxWidth: .infinity,alignment: .center)
        Image(systemName: "slider.horizontal.3")
            .padding(8)
            .background(.black.opacity(0.001))
            .onTapGesture {}
            .frame(maxWidth: .infinity,alignment: .trailing)
    }
    .font(.title2)
    .fontWeight(.medium)
    .foregroundStyle(.bumbleBlack)
}

#Preview {
    BumbleHomeView()
}
