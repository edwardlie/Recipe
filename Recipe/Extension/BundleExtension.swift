//
//  BundleExtension.swift
//  Recipe
//
//  Created by Edward Lie on 5/30/25.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) throws -> T {
        guard let url = self.url(forResource: file, withExtension: "") else {
            throw APIError.fileLocationError
        }
        
        guard let data = try? Data(contentsOf: url) else {
            throw APIError.fileLoadingError
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            throw APIError.decodeError
        }
        
        return loaded
    }
}
