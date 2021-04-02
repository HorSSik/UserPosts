//
//  CommentsCoordinator.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import UIKit

import RxSwift
import RxCocoa

enum CommentsCoordinatorEvents {
    
    case close
}

class CommentsCoordinator: BaseCoordinator<CommentsCoordinatorEvents> {
    
    // MARK: -
    // MARK: Initialization
    
    public init(
        navigationController: UINavigationController?,
        networkingService: Networking,
        callbackEvents: @escaping (CommentsCoordinatorEvents) -> ()
    ) {
        super.init(
            navigationController: navigationController,
            networking: networkingService,
            callbackEvents: callbackEvents
        )
        
        self.showPostsViewController()
    }
    
    // MARK: -
    // MARK: Private
    
    private func showPostsViewController() {
        let commentsView = PostsViewController()
        let commentsPresenter = PostsPresenter(view: commentsView, networking: self.networking)
        commentsView.presenter = commentsPresenter
        
        self.navigationController?.setViewControllers([commentsView], animated: true)
    }
}
