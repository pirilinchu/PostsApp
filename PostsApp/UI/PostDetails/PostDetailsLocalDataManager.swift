//
//  PostDetailsLocalDataManager.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 12/7/22.
//  
//

import Foundation
import RealmSwift

class PostDetailsLocalDataManager:PostDetailsLocalDataManagerInputProtocol {
    
    var localRequestHandler: PostDetailsLocalDataManagerOutputProtocol?
    
    func instantiateRealm() -> Realm {
        do {
            let realm = try Realm()
            return realm
        } catch {
            fatalError("Could not create a Realm instance")
        }
    }
    
    func getCommentsFromDatabaseFor(post: Post) {
        let comments = instantiateRealm().objects(Comment.self).filter({ $0.postID == post.id })
        localRequestHandler?.getCommentsFromDatabaseCallback(comments: Array(comments))
    }
    
    func getUserFromDatabaseFor(post: Post) {
        let user = instantiateRealm().objects(User.self).where({ $0.id == post.userID }).first ?? User()
        localRequestHandler?.getUserFromDatabaseCallback(user: user)
    }
    
    func changePostStatusFromDatabase(post: Post) {
        let realm = instantiateRealm()
        
        realm.beginWrite()
        post.isFavorite = !post.isFavorite
        do {
           try realm.commitWrite()
        } catch {
            fatalError("Error saving posts")
        }
        localRequestHandler?.changePostStatusCallBack()
    }
    
    func saveAllComments(comments: [Comment]) {
        let realm = instantiateRealm()
        
        realm.beginWrite()
        realm.delete(realm.objects(Comment.self))
        realm.add(comments)
        do {
           try realm.commitWrite()
        } catch {
            fatalError("Error saving comments")
        }
    }
    
    func saveAllUsers(users: [User]) {
        let realm = instantiateRealm()
        
        realm.beginWrite()
        realm.delete(realm.objects(User.self))
        realm.add(users)
        do {
           try realm.commitWrite()
        } catch {
            fatalError("Error saving users")
        }
    }
    
    
}
