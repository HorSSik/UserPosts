//
//  CommentsPresenter.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

import RxSwift
import RxCocoa

protocol PostsViewPresenter {
    
    init(view: PostsView, networking: NetworkingProtocol?, callbackEvents: @escaping (PostsPresenterEvents) -> ())
    
    func viewDidLoad()
    func selectPost(model: PostModel)
}

enum PostsPresenterEvents {
    
    case showComments(postModel: PostModel)
}

class PostsPresenter: BasePresenter<PostsPresenterEvents>, PostsViewPresenter {
    
    // MARK: -
    // MARK: Variables
    
    weak var view: PostsView?
    
    private var defaultUserId = 1
    
    // MARK: -
    // MARK: Initialization
    
    required init(
        view: PostsView,
        networking: NetworkingProtocol?,
        callbackEvents: @escaping (PostsPresenterEvents) -> ()
    ) {
        self.view = view
        
        super.init(networking: networking, callbackEvents: callbackEvents)
    }
    
    // MARK: -
    // MARK: CommentsViewPresenter
    
    func viewDidLoad() {
        self.getUserPosts()
    }
    
    func selectPost(model: PostModel) {
        self.callbackEvents(.showComments(postModel: model))
    }
    
    // MARK: -
    // MARK: Private
    
    private func getUserPosts() {
        guard let networking = self.networking else { return }

        let getUsers = networking.getAllUsers().asObservable()
        let getPosts = networking.getPostsBy(userId: self.defaultUserId).asObservable()

        Observable
            .combineLatest(getUsers, getPosts)
            .subscribe(
                onNext: { [weak self] users, posts in
                    let userModel = users.first { $0.id == self?.defaultUserId }
                    
                    self?.view?.updatePosts(postsModel: posts, userName: userModel?.name ?? "")
                },
                onError: { error in
                    print("Get posts by userId error - \(error.localizedDescription)")
                },
                onCompleted: { },
                onDisposed: { }
            )
            .disposed(by: self.disposeBag)
    }
}
