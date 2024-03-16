//
//  DataDecoder.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 14/01/24.
//

import Foundation

class DataDecoder {
    func decodeData<T: Decodable>(as type: T.Type, for data: Data) throws -> T {
        var errorDescription: String
        
        do {
            let data = try JSONDecoder().decode(type, from: data)
            return data
        } catch DecodingError.keyNotFound(_, let context) {
            errorDescription = context.debugDescription
        } catch DecodingError.valueNotFound(_, let context) {
            errorDescription = context.debugDescription
        } catch DecodingError.typeMismatch(_, let context) {
            errorDescription = context.debugDescription
        } catch DecodingError.dataCorrupted(let context) {
            errorDescription = context.debugDescription
        }

        throw APIError.decodingError(description: errorDescription)
    }
    
    func decodeData<T: Decodable>(
        as type: T.Type,
        for result: Result<Data, APIError>,
        completion: @escaping (Result<T, APIError>) -> Void) {
            
            switch result {
            case .success(let data):
                do {
                    let decodeData = try JSONDecoder().decode(type, from: data)
                    completion(.success(decodeData))
                } catch {
                    completion(.failure(.decodingError(description: error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
}


