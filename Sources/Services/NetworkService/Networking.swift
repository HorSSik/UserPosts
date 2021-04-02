//
//  Networking.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

import RxSwift
import RxCocoa

class Networking: NetworkingProtocol {
    
    // MARK: -
    // MARK: Variables
    
    public let networkService: NetworkService
    
    // MARK: -
    // MARK: Initialization
    
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: -
    // MARK: Public
    
    func cancel(at urlString: String) {
        self.networkService.cancel(at: urlString)
    }
    
    func cancelAll() {
        self.networkService.cancelAll()
    }
}

extension Networking {
    
    func getAllUsers() -> Single<[UserModel]> {
        let url = MainServerUrl.devUrl + "/users"
        
        return self.networkService.response(urlString: url, method: .get)
    }
    
    func getAllPosts() -> Single<[PostModel]> {
        let url = MainServerUrl.devUrl + "/posts"
        
        return self.networkService.response(urlString: url, method: .get)
    }
    
    func getAllComments() -> Single<[CommentModel]> {
        let url = MainServerUrl.devUrl + "/comments"
        
        return self.networkService.response(urlString: url, method: .get)
    }
    
    func getPostsBy(userId: Int) -> Single<[PostModel]> {
        let url = MainServerUrl.devUrl + "/posts?userId=\(userId)"
        
        return self.networkService.response(urlString: url, method: .get)
    }
}
