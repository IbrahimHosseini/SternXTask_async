//
//  MockPostService.swift
//  SternXTaskTests
//
//  Created by Ibrahim Hosseini on 2/9/24.
//

import Foundation
@testable import SternXTask_async
import XCTest

class MockPostService: PostsService {
    func getPosts() async -> (Result<[Post], NetworkError>) {
        let type = type(of: self)
        let bundle = Bundle(for: type.self)

        guard let path = bundle.url(forResource: "mockposts", withExtension: "json")
        else { return .failure(.BadURL) }

        guard let data = try? Data(contentsOf: path)
        else { return .failure(.NoData) }

        guard let model = try? JSONDecoder().decode([Post].self, from: data)
        else { return .failure(.DecodingFailed) }

        return .success(model)
    }
    
}
