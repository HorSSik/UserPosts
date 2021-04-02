//
//  NetworkService.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

import Alamofire

import RxSwift
import RxCocoa

struct MainServerUrl {
    
    static let devUrl = "https://jsonplaceholder.typicode.com"
}

class NetworkService {
    
    struct ResponseData {
        
        let data: Data?
        let response: URLResponse?
        let error: Error?
    }
    
    // MARK: -
    // MARK: Variables
    
    private var disposeBag = DisposeBag()
    
    private let requestService: RequestServiceType
    private let networkParser: NetworkParserType
    
    // MARK: -
    // MARK: Initialization
    
    public init(requestService: RequestServiceType, networkParser: NetworkParserType) {
        self.requestService = requestService
        self.networkParser = networkParser
    }
    
    // MARK: -
    // MARK: Public
    
    public func response<Value: Decodable>(
        urlString: String,
        method: HTTPMethod
    )
        -> Single<Value>
    {
        let url = URL(string: urlString)

        return Single<Value>.create { [weak self] single in
            if let url = url {
                self?.requestService.requestData(
                    url: url,
                    httpMethod: method,
                    completion: { [weak self] (data, response, error) in
                        let responseData = ResponseData(data: data, response: response, error: error)
                        
                        self?.createSingle(responseData, single)
                    }
                )
            }
            
            return Disposables.create()
        }
    }
    
    public func cancel(at urlString: String) {
        self.requestService.cancel(at: urlString)
    }
    
    public func cancelAll() {
        self.requestService.cancelAll()
    }
    
    // MARK: -
    // MARK: Private
    
    private func createSingle<Value: Decodable>(
        _ responseData: ResponseData,
        _ single: @escaping (SingleEvent<Value>) -> ())
    {
        let result: Result<Value, Error> = self.networkParser.completion(responseData)

        DispatchQueue.main.async {
            switch result {
            case .success(let value):
                single(.success(value))
            case .failure(let error):
                single(.failure(error))
            }
        }
    }
}
