//
//  Coin.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 14/01/24.
//

import Foundation

struct CoinModelWithCodable: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let marketCap: Int
    let currentPrice: Double

    enum CodingKeys: String, CodingKey {
        case id, name, symbol
        case marketCap = "market_cap"
        case currentPrice = "current_price"
    }
}


/**
 Swift Codable Protocol:

 - Codable is a Swift protocol that combines Decodable and Encodable for easy serialization/deserialization.
 - Conforming to Codable auto-generates encode(to:) and init(from:) methods based on CodingKeys.
 - Significantly reduces manual code for JSON or external data format handling.
 - Improves code readability, maintainability, and reduces errors in serialization/deserialization tasks.
 */

struct CoinModel: Identifiable, Decodable, Encodable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let marketCap: Int
    let currentPrice: Double
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol
        case image
        case marketCap = "market_cap"
        case currentPrice = "current_price"
    }

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.currentPrice = try container.decode(Double.self, forKey: .currentPrice)
        self.marketCap = try container.decode(Int.self, forKey: .marketCap)
        self.image = try container.decode(String.self, forKey: .image)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.symbol, forKey: .symbol)
        try container.encode(self.marketCap, forKey: .marketCap)
        try container.encode(self.currentPrice, forKey: .currentPrice)
        try container.encode(self.image, forKey: .image)
    }
}


