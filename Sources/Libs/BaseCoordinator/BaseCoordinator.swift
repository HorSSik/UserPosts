//
//  BaseCoordinator.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import UIKit

class BaseCoordinator<Events> {
    
    // MARK: -
    // MARK: Variables
    
//    public let networking: Networking
    
    public let callbackEvents: (Events) -> ()
    
    private(set) var navigationController: UINavigationController?
    
    // MARK: -
    // MARK: Initialization
    
    deinit {
        debugPrint("Coordinator deinit: \(type(of: self))")
    }
    
    public init(
        navigationController: UINavigationController?,
//         networking: Networking,
        callbackEvents: @escaping (Events) -> ())
    {
        self.navigationController = navigationController
//        self.networking = networking
        self.callbackEvents = callbackEvents
    }
    
    // MARK: -
    // MARK: Public
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }

    func pop(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> ())? = nil) {
        self.navigationController?.present(viewController, animated: animated, completion: completion)
    }
    
    func dissmis(animated: Bool = true, completion: (() -> ())? = nil) {
        self.navigationController?.dismiss(animated: animated, completion: completion)
    }
}

