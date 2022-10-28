//
//  HomeRemoteDataManager.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 30/6/22.
//  
//

import Foundation
import Alamofire

class HomeRemoteDataManager:HomeRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol?
    
    func getPostsFromApi() {
        AF.request("https://jsonplaceholder.typicode.com/posts", method: .get).validate(statusCode: 200..<300).responseDecodable(of: PostsResponse.self) { response in
            if let error = response.error {
                print(error.localizedDescription)
            } else {
                guard let posts = try? response.result.get() else {
                    print("parsing error")
                    return
                }
                self.remoteRequestHandler?.getPostsFromApiCallback(posts: posts)
            }
        }
    }
    
}
