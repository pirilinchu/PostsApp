//
//  User.swift
//  PostsApp
//
//  Created by Santiago Mendoza on 30/4/22.
//

import Foundation
import RealmSwift

// MARK: - User
class User: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var website: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

typealias UsersResponse = [User]
