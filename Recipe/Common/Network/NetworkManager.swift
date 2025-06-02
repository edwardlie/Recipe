//
//  NetworkManager.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import Foundation

@MainActor
public protocol NetworkManagerProtocol {
    func performRequest<T: Decodable>(request: RequestProtocol) async throws -> T
}

@MainActor
final public class NetworkManager {
    static let shared = NetworkManager(apiManager: APIManager())
    private let apiManager: APIManagerProtocol
    
    public init(apiManager: APIManagerProtocol) { self.apiManager = apiManager }
}

extension NetworkManager: NetworkManagerProtocol {
    public func performRequest<T: Decodable>(request: RequestProtocol) async throws -> T {
        let data = try await apiManager.performRequest(request)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase;
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    public func performRawRequest(request: RequestProtocol) async throws -> Data {
        try await apiManager.performRequest(request)
    }
}
