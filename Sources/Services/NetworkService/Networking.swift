//
//  Networking.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

import RxSwift
import RxCocoa

protocol NetworkingProtocol {
    
    func cancel(at urlString: String)
    func cancelAll()
    
    func getAllUsers() -> Single<MockText>
}

class Networking: NetworkingProtocol {
    
    // MARK: -
    // MARK: Variables
    
    let networkService: NetworkService = NetworkService(requestService: RequestService())
    
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
    
    func getAllUsers() -> Single<MockText> {
        let url = MainServerUrl.devUrl + "/users"
        
        return self.networkService.response(urlString: url, method: .get)
    }
}

struct MockText: Decodable {
    
    let a: Int
}
