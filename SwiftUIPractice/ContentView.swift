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
    @State private var users: [User] = []
    @State private var products: [Product] = []
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(users) { user in
                    Text(user.firstName)
                        .foregroundStyle(.spotifyGreen)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
