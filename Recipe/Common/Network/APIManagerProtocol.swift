//
//  APIManagerProtocol.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import Foundation

@MainActor
public protocol APIManagerProtocol {
    func performRequest(_ request: RequestProtocol) async throws -> Data
}
