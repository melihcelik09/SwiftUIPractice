//
//  DatabaseHelper.swift
//  SwiftUIPractice
//
//  Created by Melih on 19.08.2024.
//

import Foundation

struct DatabaseHelper {
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let products = try decoder.decode(Products.self, from: data)
        return products.products
    }
    
    func getUsers() async throws -> [User] {
        guard let url = URL(string: "https://dummyjson.com/users") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let users = try decoder.decode(Users.self, from: data)
        return users.users
    }
}



