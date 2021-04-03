//
//  CommentsTableViewCell.swift
//  UserPosts
//
//  Created by Dima Omelchenko on 02.04.2021.
//

import UIKit

struct CommentsCellModel {
    
    let title: String
    let description: String?
}

class CommentsTableViewCell: UITableViewCell {
    
    // MARK: -
    // MARK: Outleties
    
    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet private var descriptionLabel: UILabel?
    
    // MARK: -
    // MARK: Variables
    
    static var cellName: String {
        return "\(type(of: CommentsTableViewCell.self))"
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }

    // MARK: -
    // MARK: Public
    
    public func fill(with model: CommentsCellModel) {
        self.titleLabel?.text = model.title
        self.descriptionLabel?.text = model.description
        
        self.descriptionLabel?.isHidden = model.description == nil || model.description == ""
    }
}
