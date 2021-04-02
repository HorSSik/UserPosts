//
//  Protocols.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

import Alamofire

import RxSwift
import RxCocoa

protocol NetworkingProtocol {
    
    func cancel(at urlString: String)
    func cancelAll()
    
    func getAllUsers() -> Single<[UserModel]>
    func getAllPosts() -> Single<[PostModel]>
    func getAllComments() -> Single<[CommentModel]>
    
    func getPostsBy(userId: Int) -> Single<[PostModel]>
}

protocol RequestServiceType {
    
    func requestData(url: URL, httpMethod: HTTPMethod, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    
    func cancel(at urlString: String)
    func cancelAll()
}

protocol NetworkParserType {
    
    func completion<Value: Decodable>(_ responseData: NetworkService.ResponseData) -> Result<Value, Error>
}
