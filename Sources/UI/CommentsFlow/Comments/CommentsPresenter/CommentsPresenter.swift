//
//  CommentsPresenter.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 03.04.2021.
//

import Foundation

protocol CommentsViewPresenter {
    
    init(view: CommentsView, postModel: PostModel, networking: NetworkingProtocol?, callbackEvents: @escaping (CommentsPresenterEvents) -> ())
    
    func viewDidLoad()
}

enum CommentsPresenterEvents {
    
}

class CommentsPresenter: BasePresenter<CommentsPresenterEvents>, CommentsViewPresenter {
    
    // MARK: -
    // MARK: Variables
    
    weak var view: CommentsView?
    
    private let postModel: PostModel
    
    // MARK: -
    // MARK: Initialization
    
    required init(
        view: CommentsView,
        postModel: PostModel,
        networking: NetworkingProtocol?,
        callbackEvents: @escaping (CommentsPresenterEvents) -> ()
    ) {
        self.view = view
        
        self.postModel = postModel
        
        super.init(networking: networking, callbackEvents: callbackEvents)
    }
    
    // MARK: -
    // MARK: CommentsViewPresenter
    
    func viewDidLoad() {
        self.getComments()
    }
    
    // MARK: -
    // MARK: Private
    
    private func getComments() {
        guard let networking = self.networking else { return }

        networking
            .getAllComments()
            .subscribe(
                onSuccess: { [weak self] comments in
                    let filteredComments = comments.filter { $0.postId == self?.postModel.id }
                    
                    self?.view?.updatePosts(commentsModel: filteredComments)
                },
                onFailure: { error in
                    print("Get comments error - \(error.localizedDescription)")
                },
                onDisposed: { }
            )
            .disposed(by: self.disposeBag)
    }
}
