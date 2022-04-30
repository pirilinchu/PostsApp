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
    
    var posts: [Post] = []
    var favorites: [Post] {
        posts.filter({ $0.isFavorite })
    }
    var count: Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return posts.count
        } else {
            return favorites.count
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        fillData()
    }
    
    private func fillData() {
        APIManager.shared.getPosts { posts in
            self.posts = posts
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
        let cell = Bundle.main.loadNibNamed(PostTableViewCell.identifier, owner: self, options: nil)?.first as! PostTableViewCell
        cell.post = segmentedControl.selectedSegmentIndex == 0 ? posts[indexPath.row] : favorites[indexPath.row]
        cell.isOnFavorite = segmentedControl.selectedSegmentIndex == 1
        cell.setupUI()
        return cell
    }
    
    
}

extension UIColor {
    static let backgroundColor = UIColor(named: "BackgroundColor")
}

