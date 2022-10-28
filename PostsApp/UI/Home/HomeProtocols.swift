//
//  HomeProtocols.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 30/6/22.
//  
//

import Foundation
import UIKit

protocol HomeViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: HomePresenterProtocol? { get set }
    
    func getPostsForView(posts: [Post])
    func getFavoritesForView(posts: [Post])
    func handleDeleteFavorites()
    func handlePostStatusChanged()
    
    func handleReachabilityChanged(hasConnection: Bool)
}

protocol HomeWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createHomeModule() -> UIViewController
    
    func goToDetails(from: UIViewController, post: Post)
}

protocol HomePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var wireFrame: HomeWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func refreshData()
    func getFavorites()
    func deleteAllFavorites()
    func changePostStatus(post: Post)
    
    func goToDetails(from: UIViewController, post: Post)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func getPostsCallback(posts: [Post])
    func getFavoritesCallBack(posts: [Post])
    func deleteAllFavoritesCallback()
    func changePostStatusCallback()
    
    func reachabilityChanged(hasConnection: Bool)
}

protocol HomeInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: HomeInteractorOutputProtocol? { get set }
    var localDatamanager: HomeLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol? { get set }
    
    func getPosts()
    func getFavorites()
    func deleteAllFavorites()
    func changePostStatus(post: Post)
    func getReachability()
}

protocol HomeDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol HomeRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol? { get set }
    func getPostsFromApi()
}

protocol HomeRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func getPostsFromApiCallback(posts: [Post])
}

protocol HomeLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
    var localRequestHandler: HomeLocalDataManagerOutputProtocol? { get set }
    
    func getPostsFromDatabase()
    func getFavoritesFromDatabase()
    func deleteAllFavoritesFromDatabase()
    func changePostStatusFromDatabase(post: Post)
    
    func savePostsFromApi(posts: [Post])
}

protocol HomeLocalDataManagerOutputProtocol: AnyObject {
    // LOCALDATAMANAGER -> INTERACTOR
    
    func getPostsFromDatabaseCallback(posts: [Post])
    func getFavoritesFromDatabase(posts: [Post])
    func deleteAllFavoritesCallback()
    func changePostStatusCallBack()
}




protocol ReachabilityProtocol {
    var isNetworkReachable: Bool { get }
}

protocol ReachabilityNotificationProtocol {
    func reachabilityChanged()
}
