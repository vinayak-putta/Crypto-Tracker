//
//  CoinDetail.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 16/01/24.
//

import Foundation


struct CoinDetailModel: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let marketData: MarketData
    let markCapRank: Int
    let description: Description
    let symbol: String
    let image: ImageURL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case image
        case marketData = "market_data"
        case markCapRank = "market_cap_rank"
        case symbol = "symbol"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(Description.self, forKey: .description)
        self.image = try container.decode(ImageURL.self, forKey: .image)
        self.marketData = try container.decode(MarketData.self, forKey: .marketData)
        let rank = try container.decode(Int.self, forKey: .markCapRank)
        self.markCapRank = CoinDetailModel.calculateMarketCapRating(with: rank)
        self.symbol = try container.decode(String.self, forKey: .symbol)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.image, forKey: .image)
        try container.encode(self.marketData, forKey: .marketData)
        try container.encode(self.markCapRank, forKey: .markCapRank)
        try container.encode(self.symbol, forKey: .symbol)
    }
    
    private static func calculateMarketCapRating(with marketCap: Int) -> Int{
        return  5 - (marketCap % 5)
    }
}

struct MarketData: Codable, Hashable {
    let marketCapValue: MarketCap
    let currentPrice: CurrentPrice
    
    enum CodingKeys: String, CodingKey {
        case marketCapValue = "market_cap"
        case currentPrice = "current_price"
    }
}

struct CurrentPrice: Codable, Hashable {
    let usd: Double
    
    enum CodingKeys: CodingKey {
        case usd
    }
}

struct MarketCap: Codable, Hashable {
    let usd: Int
    
    enum CodingKeys: CodingKey {
        case usd
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.usd = try container.decode(Int.self, forKey: .usd)
    }
}

struct ImageURL: Codable, Hashable {
    let small: String
    let large: String
    
    enum CodingKeys: CodingKey {
        case small
        case large
    }
}

struct Description: Decodable, Encodable, Hashable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "en"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.text, forKey: .text)
    }
}
