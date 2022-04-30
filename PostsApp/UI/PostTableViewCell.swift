//
//  PostTableViewCell.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 29/4/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    static let identifier = "PostTableViewCell"
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
