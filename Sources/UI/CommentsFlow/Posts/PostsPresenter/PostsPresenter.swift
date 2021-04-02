//
//  CommentsPresenter.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

import RxSwift
import RxCocoa

protocol PostsViewPresenter: class {
    
    init(view: PostsView, networking: NetworkingProtocol?)
    func viewDidLoad()
}

class PostsPresenter: PostsViewPresenter {
    
    // MARK: -
    // MARK: Variables
    
    weak var view: PostsView?
    
    private var defaultUserId = 1
    
    private var disposeBag = DisposeBag()
    
    private var networking: NetworkingProtocol?
    
    // MARK: -
    // MARK: Initialization
    
    required init(view: PostsView, networking: NetworkingProtocol?) {
        self.view = view
        self.networking = networking
    }
    
    // MARK: -
    // MARK: CommentsViewPresenter
    
    func viewDidLoad() {
        self.getUserPosts()
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
                    DispatchQueue.main.async {
                        let userModel = users.first { $0.id == self?.defaultUserId }
                        
                        self?.view?.updatePosts(postsModel: posts, userName: userModel?.name ?? "")
                    }
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
