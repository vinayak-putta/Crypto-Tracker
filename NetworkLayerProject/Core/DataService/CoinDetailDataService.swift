//
//  CoinDetailDataService.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 15/01/24.
//

import Foundation

class CoinDetailDataService {
    
    let httpClient: HTTPClientProtocol
    let dataDecoder: DataDecoder
    
    init(httpClient: HTTPClientProtocol, dataDecoder: DataDecoder) {
        self.httpClient = httpClient
        self.dataDecoder = dataDecoder
    }

    public func fetchCoinDetail(by coinID: String) async throws -> CoinDetailModel {
        var coinDetailURLComponent = API.baseURL
        coinDetailURLComponent.path += "/\(coinID)"
        let url = coinDetailURLComponent.url?.absoluteString
        let data = try await NetworkHandler.fetchData(with: httpClient, urlString: url)
        let coinModel = try dataDecoder.decodeData(as: CoinDetailModel.self, for: data)
        return coinModel
    }
}
