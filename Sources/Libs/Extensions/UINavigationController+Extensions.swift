//
//  UINavigationController+Extensions.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import UIKit

extension UINavigationController {
    
    func setTitle(title: String) {
        self.navigationController?.navigationBar.topItem?.title = title
    }
    
    func setTitleForgroundTitleColor(_ color: UIColor) {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): color]
    }

    func setLargeTitleColor(_ color: UIColor) {
        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): color]
    }

    func setAllTitleColor(_ color: UIColor) {
        self.setTitleForgroundTitleColor(color)
        self.setLargeTitleColor(color)
    }
}
