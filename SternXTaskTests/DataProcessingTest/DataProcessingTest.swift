//
//  DataProcessingTest.swift
//  SternXTaskTests
//
//  Created by Ibrahim Hosseini on 2/9/24.
//

import XCTest
@testable import SternXTask_async

final class DataProcessingTest: XCTestCase {

    var dataProcessingService: DataProcessing!
    var postService: PostsService!

    override func setUp() {
        super.setUp()
        postService = MockPostService()
        dataProcessingService = MockDataProcessing()
    }

    override func tearDown() {
        dataProcessingService = nil
        postService = nil
        super.tearDown()
    }

    func test_averageBodyLength() async {
        let posts = await getPosts()
        let avgLength = Double((dataProcessingService.averageBodyLength(post: posts, by: 1)))

        XCTAssertEqual(avgLength, 164.5, accuracy: 1)

    }


    private func getPosts() async -> [Post] {

        let result = await postService.getPosts()

        switch result {
        case .success(let success):
            return success
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }

        return []
    }

}
