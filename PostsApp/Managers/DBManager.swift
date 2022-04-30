//
//  DBManager.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 29/4/22.
//

import Foundation
import RealmSwift

class DBManager: NSObject {
    static let shared = DBManager()

    func instantiateRealm() -> Realm {
        do {
            let realm = try Realm()
            return realm
        } catch {
            fatalError("Could not create a Realm instance")
        }
    }
    
    var posts: [Post] {
        let realm = instantiateRealm()
        return Array(realm.objects(Post.self))
    }
    
    func savePosts(posts: [Post]) {
        let realm = instantiateRealm()
        
        realm.beginWrite()
        realm.deleteAll()
        realm.add(posts)
        do {
           try realm.commitWrite()
        } catch {
            fatalError("Error saving posts")
        }
    }
    
    func changePostStatus(post: Post) -> Post {
        let realm = instantiateRealm()
        
        realm.beginWrite()
        post.isFavorite = !post.isFavorite
        do {
           try realm.commitWrite()
        } catch {
            fatalError("Error saving posts")
        }
        return post
    }
}
