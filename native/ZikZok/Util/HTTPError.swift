//
//  HTTPError.swift
//  ZikZok
//
//  Created by temp-4400 on 25/10/20.
//  Copyright © 2020 temp-4400. All rights reserved.
//

import Foundation

enum HTTPError: Error {
    case failureParsingHTTPResponse
}

extension HTTPError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .failureParsingHTTPResponse:
            return "Error parsing HTTPResponse."
        }
    }
}
