//
//  BumbleFilterView.swift
//  SwiftUIPractice
//
//  Created by Melih on 22.08.2024.
//

import SwiftUI

struct BumbleFilterView: View {
    @Binding var selection: FilterType
    @Namespace private var namespace
    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            ForEach(FilterType.allCases, id: \.self) { filter in
                VStack(spacing: 8) {
                    Text(filter.rawValue.capitalized)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    if selection == filter {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 2)
                            .matchedGeometryEffect(
                                id: "selection",
                                in: namespace
                            )
                    }
                }
                .padding(.top, 8)
                .background(.black.opacity(0.001))
                .foregroundStyle(
                    selection == filter ? .bumbleBlack : .bumbleGray
                )
                .onTapGesture {
                    selection = filter
                }
            }
        }.animation(.smooth, value: selection)
    }
}

fileprivate struct BumbleFilterViewPreview: View {
    @State private var selection: FilterType = FilterType.everyone

    var body: some View {
        BumbleFilterView(
            selection: $selection
        )
    }
}

#Preview {
    BumbleFilterViewPreview()
        .padding()
}
