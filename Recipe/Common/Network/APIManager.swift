//
//  APIManager.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import Foundation

@MainActor public class APIManager {
    public init() { }
}

extension APIManager: APIManagerProtocol {
    public func performRequest(_ request: any RequestProtocol) async throws -> Data {
        let urlRequest = try request.makeURLRequest()
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let _ = response as? HTTPURLResponse else {
                throw APIError.invalidHttpResponse
            }
            
            return data
        } catch {
            throw APIError.error(error: error)
        }
    }
}
