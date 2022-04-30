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
    
    var getPosts: [Post] {
        database.posts
    }
    
    func changePostStatus(post: Post) -> Post {
        return database.changePostStatus(post: post)
    }
}
