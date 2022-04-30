//
//  CommentDataTest.swift
//  PostsAppTests
//
//  Created by Santiago Mendoza on 30/4/22.
//

import XCTest
@testable import PostsApp

class CommentDataTest: XCTestCase {

    func testCanParseComment() throws {
        let json = """
        {
            "postId": 1,
            "id": 100001,
            "name": "id labore ex et quam laborum",
            "email": "Eliseo@gardner.biz",
            "body": "body"
          }
        """
        
        let jsonData = json.data(using: .utf8)!
        let commentData = try! JSONDecoder().decode(Comment.self, from: jsonData)
        
        XCTAssertEqual(1, commentData.postID)
        XCTAssertEqual(100001, commentData.id)
        XCTAssertEqual("id labore ex et quam laborum", commentData.name)
        XCTAssertEqual("Eliseo@gardner.biz", commentData.email)
        XCTAssertEqual("body", commentData.body)
    }
    
}
