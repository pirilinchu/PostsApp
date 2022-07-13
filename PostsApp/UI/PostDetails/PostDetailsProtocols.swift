//
//  PostDetailsProtocols.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 12/7/22.
//  
//

import Foundation
import UIKit

protocol PostDetailsViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: PostDetailsPresenterProtocol? { get set }
    
    func handleGetComments(comments: [Comment])
    func handleGetUser(user: User)
    func handlePostStatusChanged()
}

protocol PostDetailsWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createPostDetailsModule(post: Post) -> UIViewController
}

protocol PostDetailsPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: PostDetailsViewProtocol? { get set }
    var interactor: PostDetailsInteractorInputProtocol? { get set }
    var wireFrame: PostDetailsWireFrameProtocol? { get set }
    
    func viewDidLoad(post: Post)
    func changePostStatus(post: Post)
}

protocol PostDetailsInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    
    func getUserCallback(user: User)
    func getCommentsCallback(comments: [Comment])
    func changePostStatusCallback()
}

protocol PostDetailsInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: PostDetailsInteractorOutputProtocol? { get set }
    var localDatamanager: PostDetailsLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: PostDetailsRemoteDataManagerInputProtocol? { get set }
    
    func getUserFor(post: Post)
    func getCommentsFor(post: Post)
    func changePostStatus(post: Post)
}

protocol PostDetailsDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol PostDetailsRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: PostDetailsRemoteDataManagerOutputProtocol? { get set }
    
    func getCommentsFromApiFor(post: Post)
    func getUserFromApiFor(post: Post)
}

protocol PostDetailsRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func getCommentsFromApiCallback(allComments: [Comment], comments: [Comment])
    func getAllUsersFromApiCallback(allUsers: [User], user: User)
}

protocol PostDetailsLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
    var localRequestHandler: PostDetailsLocalDataManagerOutputProtocol? { get set }
    
    func getCommentsFromDatabaseFor(post: Post)
    func getUserFromDatabaseFor(post: Post)
    func changePostStatusFromDatabase(post: Post)
    
    func saveAllComments(comments: [Comment])
    func saveAllUsers(users: [User])
}

protocol PostDetailsLocalDataManagerOutputProtocol: AnyObject {
    // LOCALDATAMANAGER -> INTERACTOR
    func getCommentsFromDatabaseCallback(comments: [Comment])
    func getUserFromDatabaseCallback(user: User)
    func changePostStatusCallBack()
}
