//
//  CalculationService.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/8/24.
//

import Foundation

protocol CalculationService {
    func getCountOfPost(posts: [Post], userId: userID) -> Int
    func getUserPostsLength(posts: [Post], userId: userID) -> Int
    func calculateAverageOfPostLength(postCount: Float, bodyCount: Float) -> Float
}

class CalculationServiceImp: CalculationService {

    init(){}

    // get count of the post for a user
    func getCountOfPost(posts: [Post], userId: userID) -> Int {
        let sum = posts.sum(of: \.userId)
        return sum[userId] ?? 0
    }

    // get the length of all post body of a user
    func getUserPostsLength(posts: [Post], userId: userID) -> Int {
        let sum = posts.sum(of: \.userId, by: \.body.count)
        return sum[userId] ?? 0
    }

    // get the average character length of body for a user
    func calculateAverageOfPostLength(postCount: Float, bodyCount: Float) -> Float {
        bodyCount/postCount
    }
}
