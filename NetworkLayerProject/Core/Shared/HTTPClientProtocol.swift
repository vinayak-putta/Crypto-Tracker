//
//  HTTPClientProtocol.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 13/01/24.
//

import Foundation

protocol HTTPClientProtocol {
    /**
     Fetch data using completion handler
     **/
    func dataTaskWrapper(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTClientDataTaskProtocol
    
    /**
     Fetch data using async await
    **/
    func data(from url: URL, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

protocol HTTClientDataTaskProtocol {
    func resume()
}

extension URLSession: HTTPClientProtocol {
    func dataTaskWrapper(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTClientDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler)
    }
}

extension URLSessionDataTask: HTTClientDataTaskProtocol {}
