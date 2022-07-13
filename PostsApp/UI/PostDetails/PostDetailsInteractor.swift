//
//  PostDetailsInteractor.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 12/7/22.
//  
//

import Foundation

class PostDetailsInteractor: PostDetailsInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: PostDetailsInteractorOutputProtocol?
    var localDatamanager: PostDetailsLocalDataManagerInputProtocol?
    var remoteDatamanager: PostDetailsRemoteDataManagerInputProtocol?
    
    func getUserFor(post: Post) {
        if isNetworkReachable {
            remoteDatamanager?.getUserFromApiFor(post: post)
        } else {
            localDatamanager?.getUserFromDatabaseFor(post: post)
        }
    }
    
    func getCommentsFor(post: Post) {
        if isNetworkReachable {
            remoteDatamanager?.getCommentsFromApiFor(post: post)
        } else {
            localDatamanager?.getCommentsFromDatabaseFor(post: post)
        }
    }
    
    func changePostStatus(post: Post) {
        localDatamanager?.changePostStatusFromDatabase(post: post)
    }
    
}

extension PostDetailsInteractor: PostDetailsRemoteDataManagerOutputProtocol {
    
    func getCommentsFromApiCallback(allComments: [Comment], comments: [Comment]) {
        localDatamanager?.saveAllComments(comments: allComments)
        presenter?.getCommentsCallback(comments: comments)
    }
    
    func getAllUsersFromApiCallback(allUsers: [User], user: User) {
        localDatamanager?.saveAllUsers(users: allUsers)
        presenter?.getUserCallback(user: user)
    }
    
}

extension PostDetailsInteractor: PostDetailsLocalDataManagerOutputProtocol {
    
    func getCommentsFromDatabaseCallback(comments: [Comment]) {
        presenter?.getCommentsCallback(comments: comments)
    }
    
    func getUserFromDatabaseCallback(user: User) {
        presenter?.getUserCallback(user: user)
    }
    
    func changePostStatusCallBack() {
        presenter?.changePostStatusCallback()
    }
    
}

extension PostDetailsInteractor: ReachabilityProtocol {
    var isNetworkReachable: Bool {
        ReachabilityManager.shared.isNetworkReachable
    }

}
