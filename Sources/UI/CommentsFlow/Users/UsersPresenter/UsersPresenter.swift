//
//  UsersPresenter.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 03.04.2021.
//

import Foundation

import RxSwift
import RxCocoa

protocol UsersViewPresenter: UnlockHandable {
    
    init(
        view: UsersView,
        userUpdateModel: UserUpdateModel,
        networking: NetworkingProtocol?,
        callbackEvents: @escaping (UsersPresenterEvents) -> ()
    )
    
    func viewDidLoad()
    
    func selectUser(model: UserModel)
}

enum UsersPresenterEvents {
    
    case close
}

struct UserUpdateModel {
    
    let userModel: UserModel
    let completion: (UserModel) -> ()
}

class UsersPresenter: BasePresenter<UsersPresenterEvents>, UsersViewPresenter {
    
    // MARK: -
    // MARK: Variables
    
    weak var view: UsersView?
    
    private let userUpdateModel: UserUpdateModel
    
    // MARK: -
    // MARK: Initialization
    
    required init(
        view: UsersView,
        userUpdateModel: UserUpdateModel,
        networking: NetworkingProtocol?,
        callbackEvents: @escaping (UsersPresenterEvents) -> ()
    ) {
        self.view = view
        
        self.userUpdateModel = userUpdateModel
        
        super.init(networking: networking, callbackEvents: callbackEvents)
    }
    
    // MARK: -
    // MARK: CommentsViewPresenter
    
    func viewDidLoad() {
        self.getUsers()
    }
    
    func selectUser(model: UserModel) {
        self.userUpdateModel.completion(model)
        
        self.callbackEvents(.close)
    }
    
    // MARK: -
    // MARK: Private
    
    private func getUsers() {
        guard let networking = self.networking else { return }
        self.lockHandler?()

        networking
            .getAllUsers()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onSuccess: { [weak self] users in
                    self?.unlockHandler?()
                    
                    self?.view?.updateUsers(users: users, currentUserName: self?.userUpdateModel.userModel.name ?? "")
                },
                onFailure: { [weak self] error in // In a real application, you will need to implement error handling logic
                    self?.unlockHandler?()
                    
                    print("Get users error - \(error.localizedDescription)")
                },
                onDisposed: { }
            )
            .disposed(by: self.disposeBag)
    }
}
