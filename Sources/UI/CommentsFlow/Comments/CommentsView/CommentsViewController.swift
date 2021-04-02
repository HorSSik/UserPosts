//
//  CommentsViewController.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import UIKit

import RxSwift
import RxCocoa

protocol CommentsView: class {
    
}

class CommentsViewController: UIViewController {
    
    // MARK: -
    // MARK: Outleties
    
    @IBOutlet private var tableView: UITableView?
    
    // MARK: -
    // MARK: Variables
    
    public var defaultUserId = 1
    
    public var presenter: CommentsViewPresenter?
    
    public var networking: NetworkingProtocol?
    
    public var disposeBag = DisposeBag()
    
    public var postsModel = [PostModel]() {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    // MARK: -
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.presenter?.viewDidLoad()
        
        self.changeNavigationBarStyle()
        
        self.getUserPosts()
    }
    
    // MARK: -
    // MARK: Private
    
    private func changeNavigationBarStyle() {
        self.navigationController?.navigationBar.barTintColor = .black
        
        self.navigationController?.setAllTitleColor(.white)
    }
    
    private func getUserPosts() {
        guard let networking = self.networking else { return }
        
        let getUsers = networking.getAllUsers().asObservable()
        let getPosts = networking.getPostsBy(userId: self.defaultUserId).asObservable()
        
        Observable
            .combineLatest(getUsers, getPosts)
            .subscribe(
                onNext: { users, posts in
                    DispatchQueue.main.async {
                        let userModel = users.first { $0.id == self.defaultUserId }
                        
                        self.title = userModel?.name ?? ""
                        
                        self.postsModel = posts
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

// MARK: -
// MARK: UITableViewDataSource

extension CommentsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.backgroundColor = .clear
//        cell.largeContentTitle = self.postsModel[indexPath.row].title
//        cell.labe = self.postsModel[indexPath.row].body
        cell.textLabel?.text = self.postsModel[indexPath.row].title
        cell.textLabel?.textColor = .white
        
        cell.detailTextLabel?.text = self.postsModel[indexPath.row].body
        cell.detailTextLabel?.textColor = .lightGray
        
        return cell
        
//        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let section = self.sections[indexPath.section]
//
//            let cell = tableView.dequeueReusableCell(withCellClass: section.cell, for: indexPath)
//
//            let value = cell as? AnyCellType
//            let model = section.models[indexPath.row]
//
//            value?.fill(with: model, eventHandler: section.eventHandler)
//
//            return cell
//        }
    }
}

// MARK: -
// MARK: Description

extension CommentsViewController: UITableViewDelegate {
    
}

// MARK: -
// MARK: View Protocol

extension CommentsViewController: CommentsView {
    
}
