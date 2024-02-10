//
//  Network.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/7/24.
//

import Foundation

class Network {

    private let apiHandler: APIHandler
    private let responseHandler: ResponseHandler

    init(
        apiHandler: APIHandler,
        responseHandler: ResponseHandler
    ) {
        self.apiHandler = apiHandler
        self.responseHandler = responseHandler
    }

    func fetchRequest<T: Decodable>(type: T.Type, url: URL) async -> (Result<T, NetworkError>) {
        let request = URLRequest(url: url)

        do {
            let data = try await apiHandler.getData(type: type, url: request)
            let response = await responseHandler.getResponse(type: type, data: data)

            switch response {
            case .success(let model):
                return .success(model)
            case .failure(let error):
                return .failure(error)
            }
            
        } catch {
            return .failure(.NoData)
        }
    }
}

