//
//  MockDataProcessing.swift
//  SternXTaskTests
//
//  Created by Ibrahim Hosseini on 2/9/24.
//

import Foundation
@testable import SternXTask_async

class MockDataProcessing: DataProcessing {
    func averageBodyLength(post: [Post], by userId: userID) -> Float {
        let calculation = MockCalculationTest()

        let postCount = calculation.getCountOfPost(posts: post, userId: userId)

        let bodyCount = calculation.getUserPostsLength(posts: post, userId: userId)

        return calculation.calculateAverageOfPostLength(postCount: Float(postCount), bodyCount: Float(bodyCount))
    }
}
