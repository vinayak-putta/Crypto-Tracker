//
//  CoinViewModel.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 14/01/24.
//

import Foundation

class CoinViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var coinModels = [CoinModel]()
    
    let dataService = CoinsDataService(httpClient: URLSession.shared, dataDecoder: DataDecoder())
    
    init() {
        Task {
            await fetchCoinMarketListV2()
        }
    }

    @MainActor
    func fetchCoinMarketListV2() async {
        do {
            let coinList = try await dataService.fetchCoinsListV2()
            self.coinModels.append(contentsOf: coinList)
        } catch {
            if let error = error as? APIError {
                self.errorMessage = error.apiErrorString
                print("Custom Error: \(error.apiErrorString)")
            } else {
                self.errorMessage = error.localizedDescription
                print("Custom Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchCoinMarketListV1() {
        dataService.fetchCoinsListV1 { result in
            switch result {
            case.success(let coins):
                DispatchQueue.main.async {
                    self.coinModels.append(contentsOf: coins)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.apiErrorString
                }
            }
        }
    }
    
}
