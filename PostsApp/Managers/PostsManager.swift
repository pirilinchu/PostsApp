//
//  PostsManager.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 29/4/22.
//

import Foundation

class PostsManager {
    static let shared = PostsManager()
    
    let database = DBManager.shared
    let api = APIManager.shared
    
    var getPosts: [Post] {
        database.posts
    }
    
    func getPosts(success: @escaping(_ posts: [Post]) -> Void, failure: @escaping(_ error: Error?) -> Void) {
        guard ReachabilityManager.shared.isNetworkReachable else {
            success(database.posts)
            return
        }
        
        api.getPosts { posts in
            self.database.savePosts(posts: posts)
            success(posts)
        } failure: { error in
            failure(error)
        }
    }

    func changePostStatus(post: Post) -> Post {
        return database.changePostStatus(post: post)
    }
    
    func getCommentsForPost(post: Post, success: @escaping(_ posts: [Comment]) -> Void, failure: @escaping(_ error: Error?) -> Void) {
        guard ReachabilityManager.shared.isNetworkReachable else {
            success(database.getCommentsFor(post: post))
            return
        }
        
        api.getComments { comments in
            let commentsForPost = self.database.saveComments(post: post, comments: comments)
            success(commentsForPost)
        } failure: { error in
            failure(error)
        }
    }
    
    func getUserForPost(post: Post, success: @escaping(_ posts: User) -> Void, failure: @escaping(_ error: Error?) -> Void) {
        guard ReachabilityManager.shared.isNetworkReachable else {
            success(database.getUserFor(post: post))
            return
        }
        
        api.getUsers { users in
            let userForPost = self.database.saveUsers(post: post, users: users)
            success(userForPost)
        } failure: { error in
            failure(error)
        }
    }
    
    func getUserForPost(post: Post) -> User {
        database.getUserFor(post: post)
    }
    
}
