//
//  CommentsViewController.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import UIKit

protocol CommentsView: class {
    
}

class CommentsViewController: UIViewController {
    
    // MARK: -
    // MARK: Variables
    
    public var presenter: CommentsViewPresenter?
    
    // MARK: -
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }
}

// MARK: -
// MARK: View Protocol

extension CommentsViewController: CommentsView {
    
}
