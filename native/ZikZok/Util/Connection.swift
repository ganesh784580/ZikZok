//
//  Connection.swift
//  ZikZok
//
//  Created by temp-4400 on 25/10/20.
//  Copyright © 2020 temp-4400. All rights reserved.
//

import Foundation


protocol ConnectionProtocol {
    static func makeRequest(_ request: HTTPRequest, errorHandler: @escaping (Error) -> Void, successHandler: @escaping (Data, HTTPURLResponse) -> Void)
}




struct Connection: ConnectionProtocol {
    static func makeRequest(_ request: HTTPRequest, errorHandler: @escaping (Error) -> Void, successHandler: @escaping (Data, HTTPURLResponse) -> Void) {
        let session: URLSession = URLSession(configuration: .default)
        let request: URLRequest =  request.buildURLRequest()
        
         var requestTask: URLSessionDataTask?
         requestTask = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let requestError = error {
                    errorHandler(requestError)
                }
                guard let requestData = data, let requestResponse = response as? HTTPURLResponse else {
                    errorHandler(HTTPError.failureParsingHTTPResponse)
                    return
                }
                successHandler(requestData, requestResponse)
            }
        }
        requestTask?.resume()
    }
}
