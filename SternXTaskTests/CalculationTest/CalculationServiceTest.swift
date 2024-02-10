//
//  CalculationServiceTest.swift
//  SternXTaskTests
//
//  Created by Ibrahim Hosseini on 2/9/24.
//

import XCTest

@testable import SternXTask_async

final class CalculationServiceTest: XCTestCase {

    var calculationService: CalculationService!
    var postService: PostsService!

    override func setUp() {
        super.setUp()

        calculationService = MockCalculationTest()
        postService = MockPostService()
    }

    override func tearDown() {
        calculationService = nil
        postService = nil
        super.tearDown()
    }


    func test_countOfPost() async {
        let posts = await getPosts()
        let count = calculationService.getCountOfPost(posts: posts, userId: 1)
        XCTAssertEqual(count, 10)

    }

    func test_userPostLength() async {
        let posts = await getPosts()

        let length = calculationService.getUserPostsLength(posts: posts, userId: 1)

        XCTAssertEqual(length, 1645)
    }

    func test_averagePostLength() async {

        let avg = calculationService.calculateAverageOfPostLength(postCount: 10, bodyCount: 1645)

        XCTAssertEqual(Double(avg), 164.5, accuracy: 1)
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
