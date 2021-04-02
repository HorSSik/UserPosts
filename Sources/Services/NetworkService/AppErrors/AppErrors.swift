//
//  AppErrors.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

struct AppError {
    
    static var unknownError: NSError {
        return AppError.error()
    }
    
    static var noDataError: NSError {
        return AppError.error(text: "Data is missing")
    }
    
    static func missingError(code: Int) -> NSError {
        return AppError.error(code: code, text: "Error description is missing")
    }
    
    static func error(code: Int = 10000, text: String = "Unknown Error") -> NSError {
        return NSError(domain: "Error", code: code, userInfo: [NSLocalizedDescriptionKey : text])
    }
}
