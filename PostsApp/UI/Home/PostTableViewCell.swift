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
    
    var post: Post = Post()
    var isOnFavorite = false
    var buttonImage: UIImage {
        return post.isFavorite ? UIImage(systemName: "star.fill")! : UIImage(systemName: "star")!
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.body
        favoriteButton.setImage(buttonImage, for: .normal)
        favoriteButton.isHidden = isOnFavorite
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        post = PostsManager.shared.changePostStatus(post: post)
        setupUI()
    }
}
