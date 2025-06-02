//
//  NetworkError.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import Foundation

public enum APIError: Error {
    case urlCreationFailed
    case error(error: Error)
    case invalidHttpResponse
    case decodeError
    case fileLoadingError
    case fileLocationError
}
