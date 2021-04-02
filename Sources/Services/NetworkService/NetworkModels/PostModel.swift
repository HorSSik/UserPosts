//
//  PostModel.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

struct PostModel: Codable {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    static var mock: PostModel {
        return PostModel(
            userId: 1,
            id: 1,
            title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
            body: "quo deleniti praesentium dicta non quod"
        )
    }
}
