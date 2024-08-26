//
//  BumbleCardView.swift
//  SwiftUIPractice
//
//  Created by Melih on 23.08.2024.
//

import SwiftfulUI
import SwiftUI

struct BumbleCardView: View {
    var user: User = .mock
    var onSuperLikePressed: (()-> Void)? = nil
    var onXmarkPressed: (()-> Void)? = nil
    var onCheckmarkPressed: (()-> Void)? = nil
    var onSendAComplimentPressed: (()-> Void)? = nil
    var onHideAndReportPressed: (()-> Void)? = nil
    @State private var cardFrame: CGRect = .zero
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                headerCell
                    .frame(height: cardFrame.height)
                aboutMeSection
                    .padding(24)
                myInterestsSection
                    .padding(24)
                
                ForEach(user.gallery,id:\.self) { image in
                    ImageLoaderView(urlString: image)
                        .frame(height: cardFrame.height)
                }
                
                locationSection
                    .padding(24)
                
                footerSection
                    .padding([.bottom,.top],60)
                    .padding(24)
               
                
            }
        }
        .scrollIndicators(.hidden)
        .background(.bumbleBackgroundYellow)
        .overlay(
            alignment:.bottomTrailing,
            content: {
              superLikeButton
                    .padding(24)
        })
        .clipShape(.rect(cornerRadius: 32))
        .readingFrame { frame in
            cardFrame = frame
        }
    }
    
    private var superLikeButton: some View{
        Image(systemName: "hexagon.fill")
        .foregroundStyle(.bumbleYellow)
        .font(.system(size: 60))
        .overlay {
            Image(systemName: "star.fill")
                .foregroundStyle(.bumbleBlack)
                .font(.system(size: 30))
        }
        .onTapGesture {
            onSuperLikePressed?()
        }
    }
    
    private var footerSection: some View{
        VStack(spacing:24){
            HStack(spacing:.zero){
                Circle()
                    .fill(.bumbleYellow)
                    .overlay {
                        Image(systemName: "xmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 60,height: 60)
                    .onTapGesture {
                        onXmarkPressed?()
                    }
                Spacer()
                Circle()
                    .fill(.bumbleYellow)
                    .overlay {
                        Image(systemName: "checkmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 60,height: 60)
                    .onTapGesture {
                        onCheckmarkPressed?()
                    }
            }
            Text("Hide and Report")
                .font(.headline)
                .foregroundStyle(.bumbleGray)
                .padding(8)
                .background(.black.opacity(.zero))
                .onTapGesture {
                    onHideAndReportPressed?()
                }
        }
    }
    
    private var locationSection: some View{
        VStack(alignment:.leading,spacing: 12){
            HStack(spacing:8){
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text("\(user.name?.firstname?.capitalized ?? "")'s Location")
            }
            .foregroundStyle(.bumbleGray)
            .font(.body)
            .fontWeight(.medium)
            Text("10 miles away")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.bumbleBlack)
            InterestPillView(iconName: nil, emoji: "🇹🇷", text: "Lives in İzmir,Turkey")
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var myInterestsSection: some View{
        VStack(alignment: .leading, spacing: 12, content: {
            VStack(alignment: .leading, spacing: 8, content: {
                sectionTitle(title: "My basics")
                InterestPillGridView(interests: user.basics)
            })
            VStack(alignment: .leading, spacing: 8, content: {
                sectionTitle(title: "My interests")
                InterestPillGridView(interests: user.interests)
            })
        }).frame(maxWidth: .infinity,alignment: .leading)
        
    }

    private func sectionTitle(title: String) -> some View {
        Text(title)
            .font(.body)
            .foregroundStyle(.bumbleGray)
    }

    private var aboutMeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle(title: "About Me")
            Text(user.about)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.bumbleBlack)
            HStack(spacing: 0) {
                BumbleHeartView()
                Text("Send a Compliment")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding([.horizontal, .trailing], 8)
            .background(.bumbleYellow)
            .clipShape(.rect(cornerRadius: 32))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var headerCell: some View {
        ZStack(alignment: .bottomLeading) {
            ImageLoaderView()
            VStack(alignment: .leading, spacing: 8) {
                Text("\(user.name?.firstname ?? ""), \(user.address?.zipcode ?? "")")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                HStack(spacing: 4) {
                    Image(systemName: "suitcase")
                    Text(user.work)
                }
                HStack(spacing: 4) {
                    Image(systemName: "graduationcap")
                    Text(user.education)
                }
                BumbleHeartView()
                    .onTapGesture {}
            }
            .padding(24)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.bumbleWhite)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [
                        .clear,
                        .bumbleBlack.opacity(0.6),
                        .bumbleBlack.opacity(0.6),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
}

#Preview {
    BumbleCardView()
        .padding(.vertical, 40)
        .padding(.horizontal, 16)
}


