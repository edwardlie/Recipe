//
//  FetchStatus.swift
//  Recipe
//
//  Created by Edward Lie on 5/30/25.
//

import Foundation

public enum FetchStatus<T: Equatable, E: Error> {
    case idle
    case fetching
    case successful(data: T)
    case error(E)
}

extension FetchStatus: Equatable {
    public static func == (lhs: FetchStatus<T, E>, rhs: FetchStatus<T, E>) -> Bool {
        switch(lhs, rhs) {
        case(.idle, .idle):
            true
        case (.fetching, .fetching):
            true
        case let (.successful(leftData), .successful(rightData)):
            leftData == rightData
        case let (.error(leftError), .error(rightError)):
            leftError.localizedDescription == rightError.localizedDescription
        default:
            false
        }
    }
}

public extension FetchStatus {
    var isIdle: Bool {
        self == .idle
    }
    
    var isError: Bool {
        switch self {
        case .error:
            true
        case .idle, .fetching, .successful:
            false
        }
    }
    
    var isFetching: Bool {
        self == .fetching
    }
    
    var isSuccessful: Bool {
        switch self {
        case .successful:
            true
        case .idle, .fetching, .error:
            false
        }
    }
}
