//
//  CommentsViewController.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 03.04.2021.
//

import UIKit

protocol CommentsView: class {
    
    func updatePosts(commentsModel: [CommentModel])
}

class CommentsViewController: BaseViewController {
    
    // MARK: -
    // MARK: Outleties
    
    @IBOutlet private var tableView: UITableView?
    
    // MARK: -
    // MARK: Variables
    
    public var presenter: CommentsViewPresenter?
    
    public var commentsModel = [CommentModel]() {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    // MARK: -
    // MARK: Overrided

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setHandlers(with: self.presenter)
        
        self.presenter?.viewDidLoad()
        self.configureTable()
    }
    
    // MARK: -
    // MARK: Private
    
    private func configureTable() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(
            UINib(nibName: "CommentsTableViewCell", bundle: nil),
            forCellReuseIdentifier: CommentsTableViewCell.cellName
        )
    }
}

// MARK: -
// MARK: UITableViewDataSource

extension CommentsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.cellName, for: indexPath)
        
        let value = cell as? CommentsTableViewCell
        let commentModel = self.commentsModel[indexPath.row]
        
        value?.fill(with: CommentsCellModel(title: commentModel.email, description: commentModel.body))
        
        return value ?? UITableViewCell()
    }
}

// MARK: -
// MARK: Description

extension CommentsViewController: UITableViewDelegate {
    
}

// MARK: -
// MARK: View Protocol

extension CommentsViewController: CommentsView {
    
    func updatePosts(commentsModel: [CommentModel]) {
        self.commentsModel = commentsModel
        
        self.title = "Comments (\(commentsModel.count))"
    }
}
