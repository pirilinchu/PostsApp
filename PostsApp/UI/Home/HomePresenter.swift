//
//  HomePresenter.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 30/6/22.
//  
//

import Foundation
import UIKit

class HomePresenter {
    
    // MARK: Properties
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var wireFrame: HomeWireFrameProtocol?
}

extension HomePresenter: HomePresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        interactor?.getPosts()
        interactor?.getReachability()
    }
    
    func refreshData() {
        interactor?.getPosts()
    }
    
    func getFavorites() {
        interactor?.getFavorites()
    }
    
    func deleteAllFavorites() {
        interactor?.deleteAllFavorites()
    }
    
    func changePostStatus(post: Post) {
        interactor?.changePostStatus(post: post)
    }
    
    func goToDetails(from: UIViewController, post: Post) {
        wireFrame?.goToDetails(from: from, post: post)
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func getPostsCallback(posts: [Post]) {
        view?.getPostsForView(posts: posts)
    }
    
    func getFavoritesCallBack(posts: [Post]) {
        view?.getFavoritesForView(posts: posts)
    }
    
    func deleteAllFavoritesCallback() {
        view?.handleDeleteFavorites()
    }
    
    func changePostStatusCallback() {
        view?.handlePostStatusChanged()
    }
    
    func reachabilityChanged(hasConnection: Bool) {
        view?.handleReachabilityChanged(hasConnection: hasConnection)
    }
}
