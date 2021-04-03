//
//  BasePresenter.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 03.04.2021.
//

import Foundation

import RxSwift
import RxCocoa

class BasePresenter<Events>: NSObject {
    
    // MARK: -
    // MARK: Variables

    internal let callbackEvents: (Events) -> ()
    
    internal let networking: NetworkingProtocol?
    
    internal var disposeBag = DisposeBag()
    
    // MARK: -
    // MARK: Initialization
    
    deinit {
        debugPrint("deinit: \(type(of: self))")
    }
    
    init(
        networking: NetworkingProtocol? = nil,
        callbackEvents: @escaping (Events) -> ()
    ) {
        self.networking = networking
        self.callbackEvents = callbackEvents
    }
}
