//
//  CoinsDataService.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 14/01/24.
//

import Foundation

class CoinsDataService {
    let httpClient: HTTPClientProtocol
    let dataDecoder: DataDecoder
    var paginationCount = 0
    
    init(httpClient: HTTPClientProtocol, dataDecoder: DataDecoder) {
        self.httpClient = httpClient
        self.dataDecoder = dataDecoder
    }

    public func fetchCoinsListV1(completionHandler: @escaping (Result<[CoinModel], APIError>) -> Void) {
        var urlComponent = API.allCoinsURL
        paginationCount += 1
        urlComponent.queryItems?.append(.init(name: "page", value: String(paginationCount)))
        let urlString = urlComponent.url?.absoluteString

        NetworkHandler.fetchData(with: httpClient, urlString: urlString) { [weak self] result in
            guard let self else {
                completionHandler(.failure(.unknownError(description: "Something went wrong")))
                return
            }

            self.dataDecoder.decodeData(as: [CoinModel].self, for: result) { decodeDataResult in
                completionHandler(decodeDataResult)
            }
        }
    }

    public func fetchCoinsListV2() async throws -> [CoinModel] {
        var urlComponent = API.allCoinsURL
        paginationCount += 1
        urlComponent.queryItems?.append(.init(name: "page", value: String(paginationCount)))
        let urlString = urlComponent.url?.absoluteString

        let data = try await NetworkHandler.fetchData(with: httpClient, urlString: urlString)
        let coinsList = try dataDecoder.decodeData(as: [CoinModel].self, for: data)
        return coinsList
    }
}
