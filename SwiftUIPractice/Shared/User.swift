//
//  User.swift
//  SwiftUIPractice
//
//  Created by Melih on 19.08.2024.
//

import Foundation

struct Users: Codable{
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable,Identifiable{
    let id,age,height: Int
    let firstName,lastName,maidenName,email,phone,username,password,image: String
    let weight: Double
    
}
