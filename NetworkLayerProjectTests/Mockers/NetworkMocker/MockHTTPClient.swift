//
//  MockHTTPClient.swift
//  NetworkLayerProjectTests
//
//  Created by Vinayak Putta on 14/01/24.
//

import Foundation

@testable import NetworkLayerProject

class MockHTTPClient: HTTPClientProtocol {
    let networkStore: NetworkStoreProtocol
    
    init(networkStore: NetworkStoreProtocol) {
        self.networkStore = networkStore
    }
    
    func dataTaskWrapper(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTClientDataTaskProtocol {
        let task = MockURLSessionDataTask()
        
        // Make request
        let (data, response) = networkStore.makeRequest(with: url)
        
        // Call completion when resumed is called on task
        task.completionHander = {
            if data == nil && response == nil {
                let error = NSError()
                completionHandler(data, response, error)
            }
            completionHandler(data, response, nil)
        }
        return task
    }

    func data(from url: URL, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        let (data, response) = networkStore.makeRequest(with: url)

        guard let nonNilData = data else {
            throw APIError.invalidStatusCode(statusCode: 404)
        }
        guard let nonNilResponse = response else {
            throw APIError.responseError(description: "Response is nil")
        }

        return (nonNilData, nonNilResponse)
    }
}

class MockURLSessionDataTask: HTTClientDataTaskProtocol {
    var completionHander: (() -> ())?
    
    func resume() {
        completionHander?()
    }
}

