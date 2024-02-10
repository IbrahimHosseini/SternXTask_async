//
//  PostServicesTest.swift
//  SternXTaskTests
//
//  Created by Ibrahim Hosseini on 2/9/24.
//

import XCTest
@testable import SternXTask_async

final class PostServicesTest: XCTestCase {

    var postService: PostsService!

    override func setUp() {
        super.setUp()

        postService = MockPostService()
    }

    override func tearDown() {
        postService = nil
        super.tearDown()
    }

    // write a function to collect multi test
    // add #file value to know about the file name when error was occurred
    // add #line value to know about the line of the code name when error was occurred
    private func checkPostModelData(_ data: Post, line: Int = #line, file: StaticString = #file) {
        XCTAssertEqual(data.userId, 1)

        XCTAssertEqual(data.id, 1)

        XCTAssertEqual(data.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")

        XCTAssertEqual(data.body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
    }

    func test_fetchFistPostData() async {

        let result = await postService.getPosts()
        
        switch result {
        case .success(let posts):
            self.checkPostModelData(posts.first!)
        case .failure(let error):
            XCTFail("Error: \(error.localizedDescription)")
        }
    }

}
