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
    @objc dynamic let userID, id: Int
    @objc dynamic let title, body: String
    @objc dynamic var isFavorite = false
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
