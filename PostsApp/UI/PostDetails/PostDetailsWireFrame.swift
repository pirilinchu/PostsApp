//
//  PostDetailsWireFrame.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 12/7/22.
//  
//

import Foundation
import UIKit

class PostDetailsWireFrame: PostDetailsWireFrameProtocol {

    class func createPostDetailsModule(post: Post) -> UIViewController {
        let viewController = PostDetailsView()
        viewController.post = post
        
        let presenter: PostDetailsPresenterProtocol & PostDetailsInteractorOutputProtocol = PostDetailsPresenter()
        let interactor: PostDetailsInteractorInputProtocol & PostDetailsRemoteDataManagerOutputProtocol & PostDetailsLocalDataManagerOutputProtocol = PostDetailsInteractor()
        let localDataManager: PostDetailsLocalDataManagerInputProtocol = PostDetailsLocalDataManager()
        let remoteDataManager: PostDetailsRemoteDataManagerInputProtocol = PostDetailsRemoteDataManager()
        let wireFrame: PostDetailsWireFrameProtocol = PostDetailsWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        localDataManager.localRequestHandler = interactor
        
        return viewController
    }
}
