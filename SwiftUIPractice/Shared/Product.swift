//
//  Product.swift
//  SwiftUIPractice
//
//  Created by Melih on 19.08.2024.
//

import Foundation

struct Product: Codable,Identifiable {
    var id:Int?
    var title,description,image:String?
    var category: Category?
    var price: Double?
    var rating:Rating?
    
    enum Category: String,Codable{
        case electronics = "electronics"
        case jewelery = "jewelery"
        case menSClothing = "men's clothing"
        case womenSClothing = "women's clothing"
    }
    
    static var mock: Product{
        Product(
            id: 0,
            title: "Mock Product Title",
            description: "Some mock product description",
            image: Constants.randomImage,
            category: Category.electronics,
            price: 150,
            rating: .init(rate: 5, count: 10)
        )
    }
}

struct Rating: Codable {
    var rate: Double?
    var count: Int?
}


struct ProductRow: Identifiable{
    var id = UUID().uuidString
    var title: String
    var products: Products
    
}

typealias Products = [Product]
