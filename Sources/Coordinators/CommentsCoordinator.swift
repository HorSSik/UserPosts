//
//  CommentsCoordinator.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import UIKit

enum CommentsCoordinatorEvents {
    
    case close
}

class CommentsCoordinator: BaseCoordinator<CommentsCoordinatorEvents> {
    
    // MARK: -
    // MARK: Initialization
    
    public override init(
        navigationController: UINavigationController?,
        callbackEvents: @escaping (CommentsCoordinatorEvents) -> ()
    ) {
        super.init(
            navigationController: navigationController,
            callbackEvents: callbackEvents
        )
        
        self.showCommentsViewController()
    }
    
    // MARK: -
    // MARK: Private
    
    private func showCommentsViewController() {
        let commentsView = CommentsViewController()
        let commentsPresenter = CommentsPresenter(view: commentsView)
        commentsView.presenter = commentsPresenter
        
        self.navigationController?.setViewControllers([commentsView], animated: true)
    }
}
