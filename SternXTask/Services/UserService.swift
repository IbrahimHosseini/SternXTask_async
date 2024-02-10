//
//  UserService.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/9/24.
//

import Foundation

protocol UserService {
    func getTopUsers(posts: [Post], order: Order, countOfUser: Int) -> [userID]
}

class UserServiceImp: UserService {

    private let userProcessing: UserProcessing
    private let dataProcessing: DataProcessing

    init(
        userProcessing: UserProcessing,
        dataProcessing: DataProcessing
    ) {
        self.userProcessing = userProcessing
        self.dataProcessing = dataProcessing
    }

    // return top count of user with specific order
    func getTopUsers(posts: [Post], order: Order, countOfUser: Int) -> [userID] {

        let sortedUsers = userProcessing.sortedUsersByPostCount(
            posts: posts,
            order: order
        )

        let users = checkUsersWithSamePostCount(
            sortedUsers,
            posts: posts,
            countOfUser: countOfUser
        )

        return Array(users.prefix(countOfUser))
    }

    // check the sorted user, if they has equal post count
    private func checkUsersWithSamePostCount(_ users: [UserPostInfo], posts: [Post], countOfUser: Int) -> [userID] {

        // get the top user info for comparing with other users
        let firstUserInfo = users.first!

        // get all users that have the same post count with first top user
        let usersWithSamePostCount = users.filter { $0.postCount == firstUserInfo.postCount }

        // check if the count of same users grater than count of user.
        // in the situation we have to compare users with average post body length.
        // finally return all that users
        if usersWithSamePostCount.count >= countOfUser {
            var updateUser = [Report]()
            
            for user in usersWithSamePostCount {
                let avg = dataProcessing.averageBodyLength(post: posts, by: user.userId)
                updateUser.append(Report(userId: user.userId, avgLengthPost: avg))
            }
            
            updateUser = updateUser.sorted { $0.avgLengthPost > $1.avgLengthPost }
            
            return updateUser.map { $0.userId }

        }

        // if the count of same users less than count of user
        // return the sorted user
        return  users.map { $0.userId }
    }
}
