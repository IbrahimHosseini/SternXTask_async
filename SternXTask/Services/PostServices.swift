//
//  PostServices.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/7/24.
//

import Foundation

protocol PostsService {
    func getPosts() async -> (Result<[Post], NetworkError>)
}

class PostsServiceImp: PostsService {

    private let network: Network

    init(network: Network) {
        self.network = network
    }

    func getPosts() async -> (Result<[Post], NetworkError>) {
        guard let url = URL(string: Endpoints.posts)
        else { return .failure(.BadURL) }

        let posts = await network.fetchRequest(type: [Post].self, url: url)
        return posts
    }
}
