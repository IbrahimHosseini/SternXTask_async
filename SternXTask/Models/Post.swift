//
//  Post.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/7/24.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
