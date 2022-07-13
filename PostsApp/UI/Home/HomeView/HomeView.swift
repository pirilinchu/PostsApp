//
//  HomeView.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 29/4/22.
//

import UIKit

class HomeView: UIViewController {

    // MARK: Properties
    var presenter: HomePresenterProtocol?
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var allTableView: UITableView!
    @IBOutlet weak var offlineBanner: UIView!
    @IBOutlet weak var offlineBannerHeight: NSLayoutConstraint!
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.reloadData), for: .valueChanged)
        return refreshControl
    }
    
    var posts: [Post] = []
    
    var favorites: [Post] = []

    var hasConnection: Bool = false
    
    var count: Int {
        return isOnFavoritesPage ? favorites.count : posts.count
    }
    
    var isOnFavoritesPage: Bool {
        segmentedControl.selectedSegmentIndex == .favoritePage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupTableView()
        setupUI()
        setupRefreshControl()
        setupBanner()
    }
    
    @objc private func reloadData() {
        presenter?.refreshData()
    }
    
    private func setupBanner() {
        offlineBannerHeight.constant = hasConnection ? 0.0 : 20.0
    }
    
    private func setupRefreshControl() {
        if !isOnFavoritesPage && hasConnection {
            allTableView.refreshControl = refreshControl
        } else {
            allTableView.refreshControl = nil
        }
    }
    
    private func setupDeleteButton() {
        if !favorites.isEmpty && isOnFavoritesPage {
            navBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Remove All", style: .plain, target: self, action: #selector(buttonDeleteFavorites))
        } else {
            navBar.topItem?.rightBarButtonItem = nil
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
    
    @objc func buttonDeleteFavorites() {
        presenter?.deleteAllFavorites()
    }
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        presenter?.getFavorites()
        setupDeleteButton()
        setupRefreshControl()
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Bundle.main.loadNibNamed(PostTableViewCell.identifier, owner: self, options: nil)?.first as? PostTableViewCell else {
            return PostTableViewCell()
        }
        cell.post = isOnFavoritesPage ? favorites[indexPath.row] : posts[indexPath.row]
        cell.isOnFavorite = isOnFavoritesPage
        cell.buttonAction = {
            self.presenter?.changePostStatus(post: cell.post)
        }
        cell.setupUI()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = isOnFavoritesPage ? favorites[indexPath.row] : posts[indexPath.row]
        presenter?.goToDetails(from: self, post: post)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return isOnFavoritesPage
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let actions = [UIContextualAction(style: .destructive, title: "Delete") { _,_,_  in
            let post = self.isOnFavoritesPage ? self.favorites[indexPath.row] : self.posts[indexPath.row]
            self.presenter?.changePostStatus(post: post)
        }]
        return UISwipeActionsConfiguration(actions: actions)
    }
    
}

extension HomeView: HomeViewProtocol {
    
    func getFavoritesForView(posts: [Post]) {
        favorites = posts
        allTableView.reloadData()
        self.setupDeleteButton()
    }
    
    func getPostsForView(posts: [Post]) {
        self.posts = posts
        allTableView.refreshControl?.endRefreshing()
        allTableView.reloadData()
    }
    
    func handleDeleteFavorites() {
        presenter?.getFavorites()
    }
    
    func handlePostStatusChanged() {
        presenter?.getFavorites()
    }
    
    func handleReachabilityChanged(hasConnection: Bool) {
        self.hasConnection = hasConnection
        setupRefreshControl()
        setupBanner()
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

