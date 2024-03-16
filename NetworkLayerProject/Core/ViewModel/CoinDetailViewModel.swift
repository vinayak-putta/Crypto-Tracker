//
//  CoinDetailViewModel.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 15/01/24.
//

import Foundation

class CoinDetailViewModel: ObservableObject {
    let coinID: String
    let dataService = CoinDetailDataService(httpClient: URLSession.shared, dataDecoder: DataDecoder())
    @Published var errorMessage: String?
    @Published var coinModel: CoinDetailModel?

    init(coinID: String) {
        self.coinID = coinID
    }

    @MainActor
    public func fetchCoinDetail() async {
        do {
            let coinModel = try await dataService.fetchCoinDetail(by: self.coinID)
            self.coinModel = coinModel
        } catch {
            if let error = error as? APIError {
                self.errorMessage = error.apiErrorString
                print("custom error:", error.apiErrorString)
            } else {
                self.errorMessage = error.localizedDescription
                print("Error:", error.localizedDescription)
            }
        }
    }
    
    public func calculateMarketCapRating(with marketCap: Int) -> Int{
        return  (marketCap % 5) * 5
    }
}
