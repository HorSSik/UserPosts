//
//  UsersModel.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

struct UserModel: Codable {
    
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: AddressModel
    let phone: String
    let website: String
    let company: CompanyModel
    
    static var mock: UserModel {
        return UserModel(
            id: 1,
            name: "Leanne Graham",
            username: "Bret",
            email: "Sincere@april.biz",
            address: .mock,
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            company: .mock
        )
    }
}

struct AddressModel: Codable {
    
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: GeoModel
    
    static var mock: AddressModel {
        return AddressModel(
            street: "Kulas Light",
            suite: "Apt. 556",
            city: "Gwenborough",
            zipcode: "92998-3874",
            geo: .mock
        )
    }
}

struct GeoModel: Codable {
    
    let lat: String
    let lng: String
    
    static var mock: GeoModel {
        return GeoModel(lat: "-37.3159", lng: "81.1496")
    }
}

struct CompanyModel: Codable {
    
    let name: String
    let catchPhrase: String
    let bs: String
    
    static var mock: CompanyModel {
        return CompanyModel(
            name: "Romaguera-Crona",
            catchPhrase: "Multi-layered client-server neural-net",
            bs: "harness real-time e-markets"
        )
    }
}
