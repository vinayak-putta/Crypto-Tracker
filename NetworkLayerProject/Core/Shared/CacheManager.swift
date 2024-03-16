//
//  CacheManager.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 16/01/24.
//

import Foundation

class CacheManager {
    private let cache = NSCache<NSString, NSData>()
    
    public static let shared = CacheManager()
    
    private init() {}
    
    func object(forKey key: String) -> Data? {
        if let data = cache.object(forKey: key as NSString) {
            return data as Data
        }
        return nil
    }

    func setObject(object: Data, forKey key: String) {
        cache.setObject(object as NSData, forKey: key as NSString)
    }
}
