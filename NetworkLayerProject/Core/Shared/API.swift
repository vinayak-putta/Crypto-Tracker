//
//  API.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 14/01/24.
//

import Foundation

class API {
    static var baseURL: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3/coins"
        
        return components
    }
    
    static var allCoinsURL: URLComponents {
        var allCoinsURLComponents = API.baseURL
        allCoinsURLComponents.path += "/markets"
        allCoinsURLComponents.queryItems = [
            .init(name: "vs_currency", value: "usd"),
            .init(name: "order", value: "market_cap_desc"),
            .init(name: "per_page", value: "20"),
            .init(name: "sparkline", value: "false"),
            .init(name: "locale", value: "en")
        ]

        return allCoinsURLComponents
    }
}
