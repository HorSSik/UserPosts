//
//  NetworkParser.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

class NetworkParser: NetworkParserType {
    
    private enum Status {
        case success
        case error(Int)
    }
    
    // MARK: -
    // MARK: Public
    
    public func completion<Value: Decodable>(_ responseData: NetworkService.ResponseData) -> Result<Value, Error> {
        if let serverError = responseData.error as NSError? {
            return .failure(serverError)
        }
        
        let status = self.status(responseData.response)
        
        return self.decode(from: responseData.data, status: status)
    }
    
    // MARK: -
    // MARK: Private

    private func status(_ response: URLResponse?) -> Status {
        let statusCode = self.statusCode(from: response)
        
        switch statusCode {
        case 200...209:
            return .success
        default:
            return .error(statusCode)
        }
    }
    
    private func statusCode(from response: URLResponse?) -> Int {
        let httpURLResponse = response.flatMap { $0 as? HTTPURLResponse }
        
        return httpURLResponse?.statusCode ?? 0
    }
    
    private func decode<Value: Decodable>(from data: Data?, status: Status) -> Result<Value, Error> {
        if let data = data {
            switch status {
            case .success:
                return self.decode(data)
            case .error: // Here you can handle server errors
                return .failure(AppError.unknownError)
            }
        }

        return .failure(AppError.noDataError)
    }

    private func decode<Value: Decodable>(_ data: Data) -> Result<Value, Error> {
        do {
            let value = try JSONDecoder().decode(Value.self, from: data)
            
            return .success(value)
        } catch {
            debugPrint("Parser error: ", error)
            
            return .failure(error)
        }
    }
}
