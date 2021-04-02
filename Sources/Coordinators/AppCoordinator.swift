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
    
    public init(navigationController: UINavigationController) {
        super.init(
            navigationController: navigationController,
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
