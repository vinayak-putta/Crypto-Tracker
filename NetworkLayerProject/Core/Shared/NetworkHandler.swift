//
//  HTTPClientV2.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 13/01/24.
//

import Foundation


class NetworkHandler {
    
    // MARK: - Public methods
    
    /**
     Fetch data using completion handler
     **/
    static func fetchData(with httpClient: HTTPClientProtocol, 
                          urlString: String?,
                          isNetworkOnlyRequest: Bool = false,
                          completion: @escaping (Result<Data, APIError>) -> Void) {
        guard let urlString,
              let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        // Check data in cache
        if !isNetworkOnlyRequest {
            let (data, response) = handleCacheRequest(with: url)
            if let data,
               let response, response.statusCode == 200 {
                print("Debug: Fetched from cached")
                completion(.success(data))
                return
            }
        }

        let dataTask = httpClient.dataTaskWrapper(with: url) { data, response, error in
            // resolve error
            if let error {
                completion(.failure(.unknownError(description: error.localizedDescription)))
                return
            }
            
            do {
                // validate response
                try validateResponse(response)
            } catch {
                if let apiError = error as? APIError {
                    completion(.failure(apiError))
                    return
                } else {
                    completion(.failure(.unknownError(description: error.localizedDescription)))
                    return
                }
            }
            
            // Check data
            guard let data else {
                completion(.failure(APIError.unknownError(description: "Data cannot be nil")))
                return
            }
            completion(.success(data))
            
            // Store data in cache
            if !isNetworkOnlyRequest {
                CacheManager.shared.setObject(object: data, forKey: url.absoluteString)
            }
        }
        
        dataTask.resume()
    }
    
    /**
     Fetch data using async await
    **/
    static func fetchData(with httpClient: HTTPClientProtocol, urlString: String?, isNetworkOnlyRequest: Bool = false) async throws -> Data {
        guard let urlString,
              let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        // Check data in cache
        if !isNetworkOnlyRequest {
            let (data, response) = handleCacheRequest(with: url)
            if let data,
               let response, response.statusCode == 200 {
                print("Debug: Fetched from cached")
                return data
            }
        }
        
        // Make API call
        let (data, response) = try await httpClient.data(from: url, delegate: nil)
        try validateResponse(response)
        
        // Store data in cache
        if !isNetworkOnlyRequest {
            CacheManager.shared.setObject(object: data, forKey: url.absoluteString)
        }

        return data
    }
    
   
   // MARK: - Private helpers
    
    private static func validateResponse(_ response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.responseError(description: "Failed to case response to HTTPURLResponse")
        }
        let validRange = (200..<300)
        if !validRange.contains(httpResponse.statusCode)  {
            throw APIError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
    }
    
    private static func handleCacheRequest(with url: URL) -> (Data?, HTTPURLResponse?){
        let data = CacheManager.shared.object(forKey: url.absoluteString)
        let isFaliedRequest = data == nil ? true : false
        let response = createURLRespone(With: url, isFaliedRequest: isFaliedRequest)
        return (data, response)
    }

    private static func createURLRespone(With url: URL, isFaliedRequest: Bool = false) -> HTTPURLResponse? {
        let statusCode = isFaliedRequest ? 404 : 200

        return HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: "https",
            headerFields: nil)
    }
}
