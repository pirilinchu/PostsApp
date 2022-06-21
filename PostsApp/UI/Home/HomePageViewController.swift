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
    @IBOutlet weak var offlineBanner: UIView!
    @IBOutlet weak var offlineBannerHeight: NSLayoutConstraint!
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.fillData), for: .valueChanged)
        return refreshControl
    }
    
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
        setupDeleteButton()
        setupRefreshControl()
        setupBanner()
        registerNotifications()
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleReachabilityChanged), name: .reachabilityChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlePostHasChangedStatus), name: .postHasChangedStatus, object: nil)
    }
    
    @objc private func handlePostHasChangedStatus() {
        allTableView.reloadData()
    }
    
    @objc private func handleReachabilityChanged() {
        setupRefreshControl()
        setupBanner()
    }
    
    private func setupBanner() {
        offlineBannerHeight.constant = ReachabilityManager.shared.isNetworkReachable ? 0.0 : 20.0
    }
    
    private func setupRefreshControl() {
        if !isOnFavoritesPage && ReachabilityManager.shared.isNetworkReachable {
            allTableView.refreshControl = refreshControl
        } else {
            allTableView.refreshControl = nil
        }
    }
    
    private func setupDeleteButton() {
        if !favorites.isEmpty && isOnFavoritesPage {
            navBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Remove All", style: .plain, target: self, action: #selector(handleDeleteFavorites))
        } else {
            navBar.topItem?.rightBarButtonItem = nil
        }

    }
    
    @objc private func fillData() {
        PostsManager.shared.getPosts { posts in
            self.allTableView.refreshControl?.endRefreshing()
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
    
    @objc func handleDeleteFavorites() {
        PostsManager.shared.removeAllFavorites()
        allTableView.reloadData()
        setupDeleteButton()
    }
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        allTableView.reloadData()
        setupDeleteButton()
        setupRefreshControl()
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
            self.setupDeleteButton()
        }
        present(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return isOnFavoritesPage
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let actions = [UIContextualAction(style: .destructive, title: "Delete") { _,_,_  in
            let post = self.isOnFavoritesPage ? self.favorites[indexPath.row] : self.posts[indexPath.row]
            let _ = PostsManager.shared.changePostStatus(post: post)
            self.allTableView.reloadData()
            self.setupDeleteButton()
        }]
        return UISwipeActionsConfiguration(actions: actions)
    }
    
}

extension UIColor {
    static let backgroundColor = UIColor(named: "BackgroundColor")
}

extension Int {
    static let homePage = 0
    static let favoritePage = 1
}

extension Notification.Name {
    static let postHasChangedStatus = Notification.Name("PostHasChangedStatus")
}

