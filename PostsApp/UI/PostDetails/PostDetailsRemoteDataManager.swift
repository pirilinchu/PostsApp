//
//  PostDetailsRemoteDataManager.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 12/7/22.
//  
//

import Foundation
import Alamofire

class PostDetailsRemoteDataManager:PostDetailsRemoteDataManagerInputProtocol {

    var remoteRequestHandler: PostDetailsRemoteDataManagerOutputProtocol?
    
    func getCommentsFromApiFor(post: Post) {
        AF.request("https://jsonplaceholder.typicode.com/comments", method: .get).validate(statusCode: 200..<300).responseDecodable(of: CommentsResponse.self) { response in
            if let error = response.error {
                print(error.localizedDescription)
            } else {
                guard let comments = try? response.result.get() else {
                    print("Parsing data error")
                    return
                }
                let postComments = comments.filter({ $0.postID == post.id})
                self.remoteRequestHandler?.getCommentsFromApiCallback(allComments: comments, comments: postComments)
            }
        }
    }
    
    func getUserFromApiFor(post: Post) {
        AF.request("https://jsonplaceholder.typicode.com/users", method: .get).validate(statusCode: 200..<300).responseDecodable(of: UsersResponse.self) { response in
            if let error = response.error {
                print(error.localizedDescription)
            } else {
                guard let users = try? response.result.get() else {
                    print("Parsing data error")
                    return
                }
                let postUser = users.first(where: ({ $0.id == post.userID })) ?? User()
                self.remoteRequestHandler?.getAllUsersFromApiCallback(allUsers: users, user: postUser)
            }
        }
    }
    
}
