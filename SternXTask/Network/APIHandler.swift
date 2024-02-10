//
//  APIHandler.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/7/24.
//

import Foundation

// MARK: - API Handler

protocol APIHandler {
    func getData<T: Decodable> (type: T.Type, url: URLRequest) async throws -> Data
}

class APIHandlerImp: APIHandler {
    func getData<T>(type: T.Type, url: URLRequest) async throws -> Data where T : Decodable {
        let (data, _ ) = try await URLSession.shared.data(for: url)
        return data
    }
}
