//
//  PostDetailsViewController.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 29/4/22.
//

import UIKit

class PostDetailsViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UITextView!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var commentsView: UIView!
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    var post: Post = Post()
    var completionHandler: (() -> Void)? = nil
    var user: User {
        PostsManager.shared.getUserForPost(post: post)
    }
    var comments: [Comment] {
        PostsManager.shared.getCommentsForPost(post: post)
    }
    
    var buttonImage: UIImage {
        return post.isFavorite ? UIImage(systemName: "star.fill")! : UIImage(systemName: "star")!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fillData()
        updateUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        completionHandler?()
    }
    
    private func setupTableView() {
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
    }
    
    private func getData() {
        PostsManager.shared.getUserForPost(post: post) { _ in
            self.fillData()
            self.updateUI()
        } failure: { error in
            print("error")
        }
        
        PostsManager.shared.getCommentsForPost(post: post) { _ in
            self.commentsTableView.reloadData()
        } failure: { error in
            print("error")
        }
    }
    
    private func fillData() {
        usernameLabel.text = user.username
        emailLabel.text = user.email
        nameLabel.text = user.name
        websiteLabel.text = user.website
        
        titleLabel.text = post.title
        postDescriptionLabel.text = post.body
        
    }
    
    private func updateButton() {
        favoriteButton.setImage(buttonImage, for: .normal)
    }
    
    private func updateUI() {
        infoView.layer.cornerRadius = 10
        descriptionView.layer.cornerRadius = 10
        commentsView.layer.cornerRadius = 10
        updateButton()
        
        view.backgroundColor = .backgroundColor
    }

    @IBAction func favoriteButtonTapped(_ sender: Any) {
        post = PostsManager.shared.changePostStatus(post: post)
        updateUI()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension PostDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Bundle.main.loadNibNamed(CommentTableViewCell.identifier, owner: self, options: nil)?.first as? CommentTableViewCell else {
            return CommentTableViewCell()
        }
        cell.comment = comments[indexPath.row]
        cell.updateUI()
        cell.selectionStyle = .none
        return cell
    }
}
