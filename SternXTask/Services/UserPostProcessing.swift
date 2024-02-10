//
//  UserPostProcessing.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/10/24.
//

import Foundation

// MARK: - userPost processing

protocol UserPostProcessing {
    func sortedUserByPostsLength(post: [Post], order: Order, userIds: [userID]) -> [Report]
}

class UserPostProcessingImp: UserPostProcessing {

    private let dataProcessing: DataProcessing

    init(
        dataProcessing: DataProcessing
    ) {
        self.dataProcessing = dataProcessing
    }

    // sorted users by posts length average
    func sortedUserByPostsLength(post: [Post], order: Order, userIds: [userID]) -> [Report] {

        var userPostsLength = [Report]()

        for userId in userIds {
            let avg = dataProcessing.averageBodyLength(post: post, by: userId)
            userPostsLength.append(Report(userId: userId, avgLengthPost: avg))
        }

        if order == .ASC {
            return userPostsLength.sorted { $0.avgLengthPost < $1.avgLengthPost }
        }
        return userPostsLength.sorted { $0.avgLengthPost > $1.avgLengthPost }
    }

}
