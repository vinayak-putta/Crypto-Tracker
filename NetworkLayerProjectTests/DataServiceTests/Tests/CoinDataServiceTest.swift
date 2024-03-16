//
//  CoinDataServiceTest.swift
//  NetworkLayerProjectTests
//
//  Created by Vinayak Putta on 15/01/24.
//

import XCTest
@testable import NetworkLayerProject

final class CoinDataServiceTest: XCTestCase {
    
    func testfetchCoinsListSuccess() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&sparkline=false&locale=en&page=1"
        let networkStore = MockNetworkStore()
        networkStore.stub(url: urlString, for: MockCoinModel.coinModel)
        let mockClient = MockHTTPClient(networkStore: networkStore)
        let decoder = DataDecoder()
        let dataService = CoinsDataService(httpClient: mockClient, dataDecoder: decoder)
        
        let expectation = XCTestExpectation(description: "CoinDataService fetch coin list")
        
        dataService.fetchCoinsListV1(completionHandler: { result in
            switch result {
            case .success(let data):
                XCTAssertTrue(data.count > 0)
            case .failure(let error):
                XCTFail("Error should be nil: - \(error.apiErrorString)")
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation])
    }
    
    func testAsyncFetchCoinsListSuccess() async throws {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&sparkline=false&locale=en&page=1"
        let networkStore = MockNetworkStore()
        networkStore.stub(url: urlString, for: MockCoinModel.coinModel)
        let mockClient = MockHTTPClient(networkStore: networkStore)
        let decoder = DataDecoder()
        let dataService = CoinsDataService(httpClient: mockClient, dataDecoder: decoder)
        
        let expectation = XCTestExpectation(description: "CoinDataService fetch coin list")

        let coins = try await dataService.fetchCoinsListV2()
        XCTAssertTrue(coins.count == 3)
        expectation.fulfill()
    
        await fulfillment(of: [expectation], timeout: 0.5)
    }
}
