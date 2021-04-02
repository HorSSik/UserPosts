//
//  CommentsPresenter.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import Foundation

protocol CommentsViewPresenter: class {
    
    init(view: CommentsView)
    func viewDidLoad()
}

class CommentsPresenter: CommentsViewPresenter {
    
    // MARK: -
    // MARK: Variables
    
    weak var view: CommentsView?
    
    // MARK: -
    // MARK: Initialization
    
    required init(view: CommentsView) {
        self.view = view
    }
    
    // MARK: -
    // MARK: CommentsViewPresenter
    
    func viewDidLoad() {
        print("View did load")
    }
}
