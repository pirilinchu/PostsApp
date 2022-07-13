//
//  HomeLocalDataManager.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 30/6/22.
//  
//

import Foundation
import RealmSwift

class HomeLocalDataManager:HomeLocalDataManagerInputProtocol {
    
    var localRequestHandler: HomeLocalDataManagerOutputProtocol?
    
    func instantiateRealm() -> Realm {
        do {
            let realm = try Realm()
            return realm
        } catch {
            fatalError("Could not create a Realm instance")
        }
    }
    
    var posts: [Post] {
        Array(instantiateRealm().objects(Post.self))
    }
    
    
    func getPostsFromDatabase() {
        localRequestHandler?.getPostsFromDatabaseCallback(posts: posts)
    }
    
    func getFavoritesFromDatabase() {
        localRequestHandler?.getFavoritesFromDatabase(posts: posts.filter({ $0.isFavorite }))
    }
    
    func deleteAllFavoritesFromDatabase() {
        let realm = instantiateRealm()
        
        let favorites = realm.objects(Post.self).filter({ $0.isFavorite })
        
        realm.beginWrite()
        favorites.forEach { post in
            post.isFavorite = !post.isFavorite
        }
        do {
           try realm.commitWrite()
        } catch {
            fatalError("Error deleting favorites")
        }
        localRequestHandler?.deleteAllFavoritesCallback()
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
    
    func savePostsFromApi(posts: [Post]) {
        let realm = instantiateRealm()
        
        //update local isFavorite value on server posts
        posts.forEach { post in
            if let previousPost = self.posts.first(where: { $0.id == post.id }) {
                post.isFavorite = previousPost.isFavorite
            }
        }
        
        realm.beginWrite()
        realm.delete(self.posts)
        realm.add(posts)
        do {
           try realm.commitWrite()
        } catch {
            fatalError("Error saving posts")
        }
    }
    
}
