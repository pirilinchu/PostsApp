//
//  HomePageViewController.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 29/4/22.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var allTableView: UITableView!
    
    var posts: [Post] {
        PostsManager.shared.getPosts
    }
    var favorites: [Post] {
        posts.filter({ $0.isFavorite })
    }

    var count: Int {
        return isOnFavoritesPage ? favorites.count : posts.count
    }
    
    var isOnFavoritesPage: Bool {
        segmentedControl.selectedSegmentIndex == .favoritePage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        fillData()
    }
    
    private func fillData() {
        PostsManager.shared.getPosts { posts in
            self.allTableView.reloadData()
        } failure: { error in
            print("Error")
        }
    }
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        navBar.barTintColor = .backgroundColor
        allTableView.layer.cornerRadius = 10
    }
    
    private func setupTableView() {
        allTableView.delegate = self
        allTableView.dataSource = self
    }
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        allTableView.reloadData()
    }
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Bundle.main.loadNibNamed(PostTableViewCell.identifier, owner: self, options: nil)?.first as? PostTableViewCell else {
            return PostTableViewCell()
        }
        cell.post = isOnFavoritesPage ? favorites[indexPath.row] : posts[indexPath.row]
        cell.isOnFavorite = isOnFavoritesPage
        cell.setupUI()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = PostDetailsViewController()
        controller.post = isOnFavoritesPage ? favorites[indexPath.row] : posts[indexPath.row]
        controller.completionHandler = {
            self.allTableView.reloadData()
        }
        present(controller, animated: true)
    }
    
}

extension UIColor {
    static let backgroundColor = UIColor(named: "BackgroundColor")
}

extension Int {
    static let homePage = 0
    static let favoritePage = 1
}

