//
//  PostDataTest.swift
//  PostsAppTests
//
//  Created by Santiago Mendoza on 30/4/22.
//

import XCTest
@testable import PostsApp

class PostDataTest: XCTestCase {

    func testCanParsePost() throws {
        let json = """
        {
            "userId": 1,
            "id": 100000,
            "title": "title",
            "body": "body"
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        let postData = try! JSONDecoder().decode(Post.self, from: jsonData)
        
        XCTAssertEqual(1, postData.userID)
        XCTAssertEqual(100000, postData.id)
        XCTAssertEqual("title", postData.title)
        XCTAssertEqual("body", postData.body)
    }

}
