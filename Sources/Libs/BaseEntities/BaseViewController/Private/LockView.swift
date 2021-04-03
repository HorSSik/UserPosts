//
//  LockView.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 03.04.2021.
//

import UIKit

import SnapKit

class LockView: UIView {
    
    private enum Constants {
        static let mainColor = UIColor.clear
    }
    
    // MARK: -
    // MARK: Variables

    private let indicator = UIActivityIndicatorView()
    private var indicatorColor = UIColor.white
    
    // MARK: -
    // MARK: Initialization

    deinit {
        debugPrint("LockView deinit")
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configure()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configure()
    }

    func setIndicatorColor(_ color: UIColor) {
        self.indicator.color = color
        self.indicatorColor = color
    }
    
    // MARK: -
    // MARK: Private

    private func configure() {
        self.indicator.style = .large
        self.indicator.color = self.indicatorColor
        self.indicator.startAnimating()
        self.addSubview(self.indicator)
        
        self.indicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        self.backgroundColor = Constants.mainColor
    }
}
