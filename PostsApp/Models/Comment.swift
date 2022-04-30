//
//  Comment.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 29/4/22.
//

import Foundation
import RealmSwift

// MARK: - Comment
class Comment: Object, Codable {
    @objc dynamic var postID: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var email: String = ""
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, body, email
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

typealias CommentsResponse = [Comment]
