//
//  ReportServiceTest.swift
//  SternXTaskTests
//
//  Created by Ibrahim Hosseini on 2/10/24.
//

import XCTest

@testable import SternXTask_async

final class ReportServiceTest: XCTestCase {

    var reportService: ReportService!
    var postService: PostsService!

    override func setUp() {
        super.setUp()

        reportService = MockReportService()
        postService = MockPostService()

    }

    override func tearDown() {
        reportService = nil
        postService = nil
        super.tearDown()
    }

    func test_getReportOfFiveUsers() async {
        let posts = await getPosts()
        let report = reportService.getReport(posts: posts, order: .DES, countOfUser: 5)


        XCTAssertEqual(report.count, 5)

    }

    func test_getReportOfFiveUsersDescendingOrder() async {
        let posts = await getPosts()
        let report = reportService.getReport(posts: posts, order: .DES, countOfUser: 5)


        XCTAssertTrue(report[0].avgLengthPost >= report[1].avgLengthPost)

    }

    func test_getReportOfFiveUsersAscendingOrder() async {
        let posts = await getPosts()
        let report = reportService.getReport(posts: posts, order: .ASC, countOfUser: 5)

        XCTAssertTrue(report[0].avgLengthPost <= report[1].avgLengthPost)
    }

    func test_checkFirstTopUserInDescendingOrder() async {
        let posts = await getPosts()
        let report = reportService.getReport(posts: posts, order: .DES, countOfUser: 5)

        XCTAssertEqual(report[0].userId, 4)
        XCTAssertEqual(report[0].avgLengthPost, 182.3, accuracy: 1)
    }

    func test_checkFirstTopUserInAscendingOrder() async {
        let posts = await getPosts()
        let report = reportService.getReport(posts: posts, order: .ASC, countOfUser: 5)

        XCTAssertEqual(report[0].userId, 5)
        XCTAssertEqual(report[0].avgLengthPost, 162.5, accuracy: 1)

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
