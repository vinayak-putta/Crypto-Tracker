//
//  MockCoinModel.swift
//  NetworkLayerProjectTests
//
//  Created by Vinayak Putta on 15/01/24.
//

import Foundation


class MockCoinModel {
    static let coinModel: Data? = """
    [
      {
        "id": "bitcoin",
        "symbol": "btc",
        "name": "Bitcoin",
        "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
        "current_price": 42687,
        "market_cap": 838313511457,
        "market_cap_rank": 1,
        "fully_diluted_valuation": 898249188564,
        "total_volume": 11931881656,
        "high_24h": 43088,
        "low_24h": 42553,
        "price_change_24h": -232.7704696021101,
        "price_change_percentage_24h": -0.54234,
        "market_cap_change_24h": -3167671288.548218,
        "market_cap_change_percentage_24h": -0.37644,
        "circulating_supply": 19598775,
        "total_supply": 21000000,
        "max_supply": 21000000,
        "ath": 69045,
        "ath_change_percentage": -37.95882,
        "ath_date": "2021-11-10T14:24:11.849Z",
        "atl": 67.81,
        "atl_change_percentage": 63071.83549,
        "atl_date": "2013-07-06T00:00:00.000Z",
        "roi": null,
        "last_updated": "2024-01-14T19:39:39.057Z"
      },
      {
        "id": "ethereum",
        "symbol": "eth",
        "name": "Ethereum",
        "image": "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1696501628",
        "current_price": 2510.72,
        "market_cap": 302403077347,
        "market_cap_rank": 2,
        "fully_diluted_valuation": 302403077347,
        "total_volume": 8145441651,
        "high_24h": 2585.24,
        "low_24h": 2511.52,
        "price_change_24h": -61.6568830750507,
        "price_change_percentage_24h": -2.39688,
        "market_cap_change_24h": -6757155421.621643,
        "market_cap_change_percentage_24h": -2.18565,
        "circulating_supply": 120181730.757895,
        "total_supply": 120181730.757895,
        "max_supply": null,
        "ath": 4878.26,
        "ath_change_percentage": -48.34463,
        "ath_date": "2021-11-10T14:24:19.604Z",
        "atl": 0.432979,
        "atl_change_percentage": 581887.6543,
        "atl_date": "2015-10-20T00:00:00.000Z",
        "roi": {
          "times": 77.63703383791365,
          "currency": "btc",
          "percentage": 7763.703383791364
        },
        "last_updated": "2024-01-14T19:39:29.445Z"
      },
      {
        "id": "tether",
        "symbol": "usdt",
        "name": "Tether",
        "image": "https://assets.coingecko.com/coins/images/325/large/Tether.png?1696501661",
        "current_price": 0.998196,
        "market_cap": 94901386982,
        "market_cap_rank": 3,
        "fully_diluted_valuation": 94901386982,
        "total_volume": 25309221431,
        "high_24h": 1.002,
        "low_24h": 0.998258,
        "price_change_24h": -0.000926890356497956,
        "price_change_percentage_24h": -0.09277,
        "market_cap_change_24h": -99631015.45884705,
        "market_cap_change_percentage_24h": -0.10487,
        "circulating_supply": 95010835101.6347,
        "total_supply": 95010835101.6347,
        "max_supply": null,
        "ath": 1.32,
        "ath_change_percentage": -24.48657,
        "ath_date": "2018-07-24T00:00:00.000Z",
        "atl": 0.572521,
        "atl_change_percentage": 74.51143,
        "atl_date": "2015-03-02T00:00:00.000Z",
        "roi": null,
        "last_updated": "2024-01-14T19:35:31.676Z"
      }
    ]
    """.data(using: .utf8)
}
