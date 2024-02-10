//
//  ReportService.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/8/24.
//

import Foundation

// MARK: - report service

protocol ReportService {
    func getReport(posts: [Post], order: Order, countOfUser: Int) -> [Report]
}

class ReportServiceImp: ReportService {

    private let userService: UserService
    private let userPostProcessing: UserPostProcessing

    init(
        userService: UserService,
        userPostProcessing: UserPostProcessing
    ) {
        self.userService = userService
        self.userPostProcessing = userPostProcessing
    }

    // get report of users post based on Order and Count of user
    func getReport(posts: [Post], order: Order, countOfUser: Int) -> [Report] {

        // get top users id
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
