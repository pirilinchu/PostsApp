//
//  HomeInteractor.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 30/6/22.
//  
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: HomeInteractorOutputProtocol?
    var localDatamanager: HomeLocalDataManagerInputProtocol?
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol?
    
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changePostStatusCallBack), name: .postHasChangedStatus, object: nil)
    }

    func getPosts() {
        if isNetworkReachable {
            remoteDatamanager?.getPostsFromApi()
        } else {
            localDatamanager?.getPostsFromDatabase()
        }
    }
    
    func getFavorites() {
        localDatamanager?.getFavoritesFromDatabase()
    }
    
    func deleteAllFavorites() {
        localDatamanager?.deleteAllFavoritesFromDatabase()
    }
    
    func changePostStatus(post: Post) {
        localDatamanager?.changePostStatusFromDatabase(post: post)
    }
    
    func getReachability() {
        reachabilityChanged()
    }
    
}

extension HomeInteractor: HomeRemoteDataManagerOutputProtocol {
    
    func getPostsFromApiCallback(posts: [Post]?, error: String?) {
        guard let posts = posts else {
            presenter?.getPostsCallback(posts: [])
            return
        }
        localDatamanager?.savePostsFromApi(posts: posts)
        presenter?.getPostsCallback(posts: posts)
    }

}

extension HomeInteractor: HomeLocalDataManagerOutputProtocol {
    
    func getPostsFromDatabaseCallback(posts: [Post]) {
        presenter?.getPostsCallback(posts: posts)
    }
    
    func getFavoritesFromDatabase(posts: [Post]) {
        presenter?.getFavoritesCallBack(posts: posts)
    }

    func deleteAllFavoritesCallback() {
        presenter?.deleteAllFavoritesCallback()
    }
    
    @objc func changePostStatusCallBack() {
        presenter?.changePostStatusCallback()
    }
}

// MARK: Reachabilility
extension HomeInteractor: ReachabilityProtocol, ReachabilityNotificationProtocol {
    var isNetworkReachable: Bool {
        ReachabilityManager.shared.isNetworkReachable
    }
    
    @objc func reachabilityChanged() {
        presenter?.reachabilityChanged(hasConnection: isNetworkReachable)
    }
    
}
