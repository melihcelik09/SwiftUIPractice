//
//  DatabaseHelper.swift
//  SwiftUIPractice
//
//  Created by Melih on 19.08.2024.
//

import Foundation

struct DatabaseHelper {
    func getProducts() async throws -> Products {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let products = try decoder.decode(Products.self, from: data)
        return products
    }
    
    func getUsers() async throws -> Users {
        guard let url = URL(string: "https://fakestoreapi.com/users") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let users = try decoder.decode(Users.self, from: data)
        return users
    }
}



