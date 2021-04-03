//
//  BaseViewController.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 03.04.2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: -
    // MARK: Variables
    
    private var lockView: LockView?
    
    // MARK: -
    // MARK: Public
    
    public func setHandlers(with presenter: UnlockHandable?) {
        guard let presenter = presenter else { return }
        
        presenter.lockHandler = { [weak self] in self?.lock() }
        presenter.unlockHandler = { [weak self] in self?.unlock() }
    }
    
    public func lock(on view: UIView? = nil, color: UIColor? = nil) {
        let lockView = LockView()
        lockView.backgroundColor = color ?? .clear
        
        if view != nil {
            view?.addSubview(lockView)
            
            lockView.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalToSuperview()
            }
            
            view?.bringSubviewToFront(lockView)
        } else {
            self.view.addSubview(lockView)
            
            lockView.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
            }
            
            self.view.bringSubviewToFront(lockView)
        }
        self.unlock()
        self.lockView = lockView
    }
    
    public func unlock() {
        self.lockView?.removeFromSuperview()
        self.lockView = nil
    }
}
