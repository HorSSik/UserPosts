//
//  CommentsPresenter.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

import RxSwift
import RxCocoa

protocol PostsViewPresenter: UnlockHandable {
    
    init(view: PostsView, networking: NetworkingProtocol?, callbackEvents: @escaping (PostsPresenterEvents) -> ())
    
    func viewDidLoad()
    
    func selectPost(model: PostModel)
    func changeUser()
}

enum PostsPresenterEvents {
    
    case showComments(postModel: PostModel)
    case showUsers(userUpdateModel: UserUpdateModel)
}

class PostsPresenter: BasePresenter<PostsPresenterEvents>, PostsViewPresenter {
    
    // MARK: -
    // MARK: Variables
    
    weak var view: PostsView?
    
    private var defaultUserId = 1 {
        didSet {
            self.getUserPosts()
        }
    }
    
    private var userModel: UserModel?
    
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
    
    func changeUser() {
        guard let userModel = self.userModel else { return }
        
        let userUpdateModel = UserUpdateModel(
            userModel: userModel,
            completion: { [weak self] userModel in
                self?.defaultUserId = userModel.id
            }
        )
        
        self.callbackEvents(.showUsers(userUpdateModel: userUpdateModel))
    }
    
    // MARK: -
    // MARK: Private
    
    private func getUserPosts() {
        guard let networking = self.networking else { return }
        self.lockHandler?()

        let getUsers = networking.getAllUsers().asObservable()
        let getPosts = networking.getPostsBy(userId: self.defaultUserId).asObservable()

        Observable
            .combineLatest(getUsers, getPosts)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] users, posts in
                    self?.unlockHandler?()
                    
                    let userModel = users.first { $0.id == self?.defaultUserId }
                    
                    self?.userModel = userModel
                    self?.view?.updatePosts(postsModel: posts, userName: userModel?.name ?? "")
                },
                onError: { [weak self] error in // In a real application, you will need to implement error handling logic
                    self?.unlockHandler?()
                    
                    print("Get posts by userId error - \(error.localizedDescription)")
                },
                onCompleted: { },
                onDisposed: { }
            )
            .disposed(by: self.disposeBag)
    }
}
