//
//  ResponseHandler.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/7/24.
//

import Foundation

// MARK: - Response Handler
protocol ResponseHandler {
    func getResponse<T: Decodable>(type: T.Type, data: Data) async -> (Result<T, NetworkError>)
}

class ResponseHandlerImp: ResponseHandler {
    func getResponse<T>(type: T.Type, data: Data) async -> (Result<T, NetworkError>) where T : Decodable {
        
        do {
            let response = try JSONDecoder().decode(type.self, from: data)
            return .success(response)
        } catch {
            return.failure(.DecodingFailed)
        }
    }
}
