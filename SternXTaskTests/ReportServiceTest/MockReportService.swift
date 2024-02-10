//
//  MockReportService.swift
//  SternXTaskTests
//
//  Created by Ibrahim Hosseini on 2/10/24.
//

import Foundation

@testable import SternXTask_async

class MockReportService: ReportService {
    func getReport(posts: [Post], order: Order, countOfUser: Int) -> [Report] {
        // get top users id

        let dataProcessing =  DataProcessingImp(calculationService: CalculationServiceImp())

        let userService = UserServiceImp(
            userProcessing: UserProcessingImp(calculationService: CalculationServiceImp()),
            dataProcessing: dataProcessing
        )

        let userPostProcessing = UserPostProcessingImp(dataProcessing: dataProcessing)

        let userIds = userService.getTopUsers(
            posts: posts,
            order: order,
            countOfUser: countOfUser
        )

        var topUsersPosts = [Post]()

        // filter all posts with only top users post
        for userId in userIds {
            let userPosts = posts.filter { $0.userId == userId }
            topUsersPosts.append(contentsOf: userPosts)
        }

        // sorted report with users and average character length
        let sortedReport = userPostProcessing.sortedUserByPostsLength(
            post: topUsersPosts,
            order: order,
            userIds: userIds
        )

        return sortedReport
    }
    

}
