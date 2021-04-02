//
//  CommentsModel.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

struct CommentModel: Codable {
    
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
    
    static var mock: CommentModel {
        return CommentModel(
            postId: 1,
            id: 1,
            name: "id labore ex et quam laborum",
            email: "Eliseo@gardner.biz",
            body: "tempora voluptatem est\nmagnam distinctio autem"
        )
    }
}
