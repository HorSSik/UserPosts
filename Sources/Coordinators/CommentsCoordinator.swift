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
        let postsView = PostsViewController()
        let postsPresenter = PostsPresenter(
            view: postsView,
            networking: self.networking,
            callbackEvents: { [weak self] event in
                self?.handle(event: event)
            }
        )
        postsView.presenter = postsPresenter
        
        self.navigationController?.setViewControllers([postsView], animated: true)
    }
    
    private func handle(event: PostsPresenterEvents) {
        switch event {
        case .showComments(let postModel):
            self.showCommentsViewController(postModel: postModel)
        case .showUsers(let userUpdateModel):
            self.showUsersViewController(userUpdateModel: userUpdateModel)
        }
    }
    
    private func showCommentsViewController(postModel: PostModel) {
        let commentsView = CommentsViewController()
        let commentsPresenter = CommentsPresenter(
            view: commentsView,
            postModel: postModel,
            networking: self.networking,
            callbackEvents: { _ in }
        )
        commentsView.presenter = commentsPresenter
        
        self.push(commentsView, animated: true)
    }
    
    private func showUsersViewController(userUpdateModel: UserUpdateModel) {
        let usersView = UsersViewController()
        let usersPresenter = UsersPresenter(
            view: usersView,
            userUpdateModel: userUpdateModel,
            networking: self.networking,
            callbackEvents: { [weak self] event in
                self?.handle(event: event)
            }
        )
        usersView.presenter = usersPresenter
        
        self.push(usersView, animated: true)
    }
    
    private func handle(event: UsersPresenterEvents) {
        switch event {
        case .close:
            self.pop(animated: true)
        }
    }
}
