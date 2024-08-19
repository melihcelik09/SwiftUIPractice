//
//  Product.swift
//  SwiftUIPractice
//
//  Created by Melih on 19.08.2024.
//

import Foundation

struct Products: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable,Identifiable{
    let id, price, stock: Int
    let title, description, brand, category, thumbnail: String
    let discountPercentage, rating: Double
    let images: [String]
    var firstImage: String{
        images.first ?? Constants.randomImage
    }
}
