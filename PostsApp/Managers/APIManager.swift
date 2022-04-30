//
//  APIManager.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 29/4/22.
//

import Foundation
import Alamofire

class APIManager {

    static let shared = APIManager()
    
    func getPosts(success: @escaping(_ posts: [Post]) -> Void, failure: @escaping(_ error: Error?) -> Void) {
        
        AF.request("https://jsonplaceholder.typicode.com/posts", method: .get).validate(statusCode: 200..<300).responseDecodable(of: PostsResponse.self) { response in
            if let error = response.error {
                failure(error)
            } else {
                guard let posts = try? response.result.get() else {
                    failure(nil)
                    return
                }
                success(posts)
            }
        }
    }
    
    func getComments(success: @escaping(_ posts: [Comment]) -> Void, failure: @escaping(_ error: Error?) -> Void) {
        
        AF.request("https://jsonplaceholder.typicode.com/comments", method: .get).validate(statusCode: 200..<300).responseDecodable(of: CommentsResponse.self) { response in
            if let error = response.error {
                failure(error)
            } else {
                guard let comments = try? response.result.get() else {
                    failure(nil)
                    return
                }
                success(comments)
            }
        }
    }
}
