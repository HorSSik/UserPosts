//
//  CommentsModel.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

class CommentsModel {
    
    // MARK: -
    // MARK: Variables
    
    private(set) var userName: String
    
    private(set) var title: String
    private(set) var description: String
    
    // MARK: -
    // MARK: Initialization
    
    public init(userName: String, title: String, description: String) {
        self.userName = userName
        self.title = title
        self.description = description
    }
}
