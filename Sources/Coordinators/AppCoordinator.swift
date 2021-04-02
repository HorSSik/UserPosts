//
//  AppCoordinator.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import UIKit

enum AppCoordinatorEvents {
    
}

class AppCoordinator: BaseCoordinator<AppCoordinatorEvents> {
    
    // MARK: -
    // MARK: Variables
    
    private var commentsCoordinator: CommentsCoordinator?
    
    // MARK: -
    // MARK: Initialization
    
    public init(navigationController: UINavigationController, networking: Networking) {
        super.init(
            navigationController: navigationController,
            networking: networking,
            callbackEvents: { _ in }
        )
        
        self.showCommentsCoordinator()
    }
    
    // MARK: -
    // MARK: Private
    
    private func showCommentsCoordinator() {
        self.navigationController?.isNavigationBarHidden = true
        
        let commentsCoordinator = CommentsCoordinator(
            navigationController: self.navigationController,
            networkingService: self.networking,
            callbackEvents: { event in
                
            }
        )
        
        self.commentsCoordinator = commentsCoordinator
    }
    
    private func handle(event: CommentsCoordinatorEvents) {
        switch event {
        case .close:
            self.commentsCoordinator = nil
        }
    }
}
