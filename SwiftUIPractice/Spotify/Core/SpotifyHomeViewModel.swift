//
//  SpotifyHomeViewModel.swift
//  SwiftUIPractice
//
//  Created by Melih on 22.08.2024.
//

import Foundation
import SwiftfulRouting


@Observable
final class SpotifyHomeViewModel{
    let router: AnyRouter
    var currentUser: User? = nil
    var selectedCategory: Category? = nil
    var products = [Product]()
    var productRows = [ProductRow]()
    
    init(router: AnyRouter) {
        self.router = router
    }
    
    func getData() async {
        guard products.isEmpty else {return}
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            let allProducts = try await DatabaseHelper().getProducts()
            products = Array(allProducts.prefix(8))
            var rows: [ProductRow] = []
            let allCategories = Set(allProducts.map({ $0.category }))
            for category in allCategories {
                let products = allProducts.filter({ $0.category == category })
                rows.append(
                    ProductRow(title: category?.rawValue ?? "", products: products)
                )
            }
            productRows = rows
        } catch {
            print(error.localizedDescription)
        }
    }
}
