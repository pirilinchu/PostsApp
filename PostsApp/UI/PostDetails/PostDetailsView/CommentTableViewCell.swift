//
//  CommentTableViewCell.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 30/4/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    static let identifier = "CommentTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var comment: Comment = Comment()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    func updateUI() {
        nameLabel.text = comment.name
        bodyLabel.text = comment.body
    }
    
}
