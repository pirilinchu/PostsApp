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
        Array(instantiateRealm().objects(Post.self))
    }
    
    func savePosts(posts: [Post]) {
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
    
    func getCommentsFor(post: Post) -> [Comment] {
        return instantiateRealm().objects(Comment.self).filter({ $0.postID == post.id })
    }
    
    func saveComments(post: Post, comments: [Comment]) -> [Comment] {
        let realm = instantiateRealm()
        
        realm.beginWrite()
        realm.delete(realm.objects(Comment.self))
        realm.add(comments)
        do {
           try realm.commitWrite()
        } catch {
            fatalError("Error saving comments")
        }
        
        return getCommentsFor(post: post)
    }
    
    func getUserFor(post: Post) -> User {
        return instantiateRealm().objects(User.self).where({ $0.id == post.userID }).first ?? User()
    }
    
    func saveUsers(post: Post, users: [User]) -> User {
        let realm = instantiateRealm()
        
        realm.beginWrite()
        realm.delete(realm.objects(User.self))
        realm.add(users)
        do {
           try realm.commitWrite()
        } catch {
            fatalError("Error saving comments")
        }
        
        return getUserFor(post: post)
    }
}
