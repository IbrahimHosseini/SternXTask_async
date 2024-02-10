//
//  NetworkError.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/7/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case BadURL
    case NoData
    case DecodingFailed

    var errorDescription: String? {
        switch self {
        case .BadURL: "Bad Url"
        case .NoData: "No Data"
        case .DecodingFailed: "Decoding Failed"
        }
    }
}
