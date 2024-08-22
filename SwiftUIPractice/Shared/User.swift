//
//  User.swift
//  SwiftUIPractice
//
//  Created by Melih on 19.08.2024.
//

import Foundation

struct User: Codable,Identifiable{
    var address: Address?
    var id: Int?
    var email, username, password, phone: String?
    var name: Name?
    
    static var mock: User{
        User(
            address: .init(
                geolocation: .init(
                    lat: "38.423733",
                    long: "27.142826"
                ),
                city: "İzmir",
                street: "Konak",
                zipcode: "35000",
                number: 0
            ),
            id: 0,
            email: "melihcelikcodes@gmail.com",
            username: "melihcelik",
            password: "",
            phone: "",
            name: .init(firstname: "Melih", lastname: "Çelik")
        )
    }
}

struct Address: Codable {
    var geolocation: Geolocation?
    var city, street,zipcode: String?
    var number: Int?
}

struct Geolocation: Codable {
    var lat, long: String?
}

// MARK: - Name
struct Name: Codable {
    var firstname, lastname: String?
}

typealias Users = [User]


