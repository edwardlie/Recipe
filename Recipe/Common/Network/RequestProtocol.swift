//
//  RequestProtocol.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import Foundation

public enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

@MainActor
public protocol RequestProtocol {
    var path: String { get }
    var requestType: RequestType { get }
}

public extension RequestProtocol {
    func makeURLRequest() throws -> URLRequest {
        let url = try buildURL()
        return try buildURLRequest(url: url)
    }
}

public extension RequestProtocol {
    func buildURL() throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = .https
        urlComponents.path = path
        urlComponents.host = "d3jbb8n5wk0qxi.cloudfront.net"
        
        guard let url = urlComponents.url else {
            throw APIError.urlCreationFailed
        }
        
        return url
    }
    
    func buildURLRequest(url: URL) throws -> URLRequest {
        var urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        
        urlRequest.httpMethod = requestType.rawValue
        
        return urlRequest
    }
}

extension String {
    static let https = "https"
}
