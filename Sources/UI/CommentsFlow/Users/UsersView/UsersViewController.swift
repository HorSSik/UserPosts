//
//  UsersViewController.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 03.04.2021.
//

import UIKit

protocol UsersView: class {
    
    func updateUsers(users: [UserModel], currentUserName: String)
}

class UsersViewController: BaseViewController {
    
    // MARK: -
    // MARK: Outleties
    
    @IBOutlet private var tableView: UITableView?
    
    // MARK: -
    // MARK: Variables
    
    public var presenter: UsersViewPresenter?
    
    public var usersModel = [UserModel]() {
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

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.cellName, for: indexPath)
        
        let value = cell as? CommentsTableViewCell
        let userModel = self.usersModel[indexPath.row]
        
        value?.fill(with: CommentsCellModel(title: "\(userModel.name) (\(userModel.username))", description: ""))
        
        return value ?? UITableViewCell()
    }
}

// MARK: -
// MARK: UITableViewDelegate

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userModel = self.usersModel[indexPath.row]
        
        self.presenter?.selectUser(model: userModel)
    }
}

// MARK: -
// MARK: View Protocol

extension UsersViewController: UsersView {
    
    func updateUsers(users: [UserModel], currentUserName: String) {
        self.usersModel = users
        
        self.title = currentUserName
    }
}
