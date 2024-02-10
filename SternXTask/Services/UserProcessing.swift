//
//  UserProcessing.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/8/24.
//

import Foundation

typealias userID = Int

// MARK: - User processing

protocol UserProcessing {
    func sortedUsersByPostCount(posts: [Post], order: Order) -> [UserPostInfo]
}

class UserProcessingImp: UserProcessing {

    private let calculationService: CalculationService

    init(
        calculationService: CalculationService
    ) {
        self.calculationService = calculationService
    }

    // sorted users with post count
    func sortedUsersByPostCount(posts: [Post], order: Order) -> [UserPostInfo] {
        let allUsersWithPostCount = getAllUsersWithPostsCount(posts: posts)

        if order == .ASC {
            return allUsersWithPostCount.sorted { $0.postCount < $1.postCount }
        }
        return allUsersWithPostCount.sorted { $0.postCount > $1.postCount }
    }
}

extension UserProcessingImp {

    // get all users with count of posts
    private func getAllUsersWithPostsCount(posts: [Post]) -> [UserPostInfo] {
        let userIds = getUserIds(posts: posts)
        var userPosts = [UserPostInfo]()

        for userId in userIds {
            let count = calculationService.getCountOfPost(posts: posts, userId: userId)
            userPosts.append(UserPostInfo(userId: userId, postCount: count))
        }
        return userPosts
    }

    // get users that release a post
    private func getUserIds(posts: [Post]) -> [userID] {
        posts.map { $0.userId }.unique()
    }

}
