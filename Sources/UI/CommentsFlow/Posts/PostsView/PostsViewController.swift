//
//  PostsViewController.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import UIKit

protocol PostsView: class {
    
    func updatePosts(postsModel: [PostModel], userName: String)
}

class PostsViewController: BaseViewController {
    
    // MARK: -
    // MARK: Outleties
    
    @IBOutlet private var tableView: UITableView?
    
    // MARK: -
    // MARK: Variables
    
    public var presenter: PostsViewPresenter?
    
    public var postsModel = [PostModel]() {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    // MARK: -
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setHandlers(with: self.presenter)
        
        self.configureTable()
        self.configureNavigationBar()
        
        self.presenter?.viewDidLoad()
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
    
    private func configureNavigationBar() {
        let navigationBar = self.navigationController?.navigationBar
        let usersButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.showUsers))
        usersButton.image = UIImage(named: "users_icon")
        
        navigationBar?.barTintColor = .black
        navigationBar?.topItem?.backButtonTitle = ""
        navigationBar?.tintColor = .white
        
        self.navigationItem.rightBarButtonItem = usersButton
        self.navigationController?.setAllTitleColor(.white)
    }
    
    @objc func showUsers(sender: UIBarButtonItem) {
        self.presenter?.changeUser()
    }
}

// MARK: -
// MARK: UITableViewDataSource

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.cellName, for: indexPath)
        
        let value = cell as? CommentsTableViewCell
        let postModel = self.postsModel[indexPath.row]
        
        value?.fill(with: CommentsCellModel(title: postModel.title, description: postModel.body))
        
        return value ?? UITableViewCell()
    }
}

// MARK: -
// MARK: Description

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postModel = self.postsModel[indexPath.row]
        
        self.presenter?.selectPost(model: postModel)
    }
}

// MARK: -
// MARK: View Protocol

extension PostsViewController: PostsView {
    
    func updatePosts(postsModel: [PostModel], userName: String) {
        self.postsModel = postsModel
        self.title = userName
    }
}
