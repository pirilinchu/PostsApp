//
//  Post.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 29/4/22.
//

import Foundation
import RealmSwift

// MARK: - Post
class Post: Object, Codable {
    @objc dynamic var userID: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var isFavorite = false
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

typealias PostsResponse = [Post]
