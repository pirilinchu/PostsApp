//
//  PostDetailsPresenter.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 12/7/22.
//  
//

import Foundation

class PostDetailsPresenter  {
    
    // MARK: Properties
    weak var view: PostDetailsViewProtocol?
    var interactor: PostDetailsInteractorInputProtocol?
    var wireFrame: PostDetailsWireFrameProtocol?
    
}

extension PostDetailsPresenter: PostDetailsPresenterProtocol {

    func viewDidLoad(post: Post) {
        interactor?.getUserFor(post: post)
        interactor?.getCommentsFor(post: post)
    }
    
    func changePostStatus(post: Post) {
        interactor?.changePostStatus(post: post)
    }
    
}

extension PostDetailsPresenter: PostDetailsInteractorOutputProtocol {
    func getUserCallback(user: User) {
        view?.handleGetUser(user: user)
    }
    
    func getCommentsCallback(comments: [Comment]) {
        view?.handleGetComments(comments: comments)
    }
    
    func changePostStatusCallback() {
        view?.handlePostStatusChanged()
    }

}
