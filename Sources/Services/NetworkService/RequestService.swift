//
//  RequestService.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

import Alamofire

protocol RequestServiceType {
    
    func requestData(url: URL, httpMethod: HTTPMethod, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    
    func cancel(at urlString: String)
    func cancelAll()
}

class RequestService: RequestServiceType {
    
    // MARK: -
    // MARK: Typealias
    
    typealias ResultValue = (Data?, URLResponse?, Error?) -> ()
    
    // MARK: -
    // MARK: Variables
    
    private let session: URLSession
    
    // MARK: -
    // MARK: Initialization
    
    public init() {
        self.session = URLSession.shared
    }
    
    // MARK: -
    // MARK: Public

    public func requestData(url: URL, httpMethod: HTTPMethod, completion: @escaping ResultValue) {
        let dataRequest = AF
            .request(url, method: httpMethod)
            .response(
                completionHandler: { response in
                    completion(response.data, response.response, response.error)
                }
            )
        
        if let request = dataRequest.request {
            self.session.dataTask(with: request).resume()
        }
    }
    
    public func cancel(at urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        self.session.dataTask(with: url).cancel()
    }
    
    public func cancelAll() {
        self.session.getAllTasks {
            $0.forEach { $0.cancel() }
        }
    }
}
