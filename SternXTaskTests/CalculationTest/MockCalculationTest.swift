//
//  MockCalculationTest.swift
//  SternXTaskTests
//
//  Created by Ibrahim Hosseini on 2/9/24.
//

import Foundation
@testable import SternXTask_async

class MockCalculationTest: CalculationService {
    func getCountOfPost(posts: [Post], userId: userID) -> Int {
        let sum = posts.sum(of: \.userId)
        return sum[userId] ?? 0
    }
    
    func getUserPostsLength(posts: [Post], userId: userID) -> Int {
        let sum = posts.sum(of: \.userId, by: \.body.count)
        return sum[userId] ?? 0
    }
    
    func calculateAverageOfPostLength(postCount: Float, bodyCount: Float) -> Float {
        bodyCount/postCount
    }
}
