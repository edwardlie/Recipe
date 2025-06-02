//
//  ImageCache.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import Foundation
import UIKit
import SwiftUICore

public enum LoadingError: Error {
    case error(String)
}

public actor ImageCache {
    enum LoadingState<T> {
        case loading(Task<T, Error>)
        case completed(Data)
        case failed(Error)
    }
    
    static let shared = ImageCache(imageFetcher: RemoteImageFetcher())
    var imageData: [String: LoadingState<Data>] = [:]
    private let imageFetcher: ImageFetcherProtocol
    
    init(imageFetcher: ImageFetcherProtocol) {
        self.imageFetcher = imageFetcher
    }
    
    public func fetchImage(filePath: String) async throws -> Data {
        if let state = imageData[filePath] {
            return try await getCurrentStatus(state: state)
        }

        let task = Task <Data, Error> {
            return try await imageFetcher.fetchImage(filePath: filePath)
        }
        
        imageData[filePath] = .loading(task)
        
        do {
            let imageURLData = try await task.value
            imageData[filePath] = .completed(imageURLData)
            return imageURLData
        } catch {
            imageData[filePath] = .failed(LoadingError.error(error.localizedDescription))
            throw LoadingError.error(error.localizedDescription)
        }
    }
}

private extension ImageCache {
    func getCurrentStatus(state: LoadingState<Data>) async throws -> Data {
        switch state {
        case .loading(let task):
            return try await task.value
        case .completed(let imageURLData):
            return imageURLData
        case .failed(let error):
            throw error
        }
    }
}

//public struct ImageURLData: Sendable {
//    public let filePath: String
//    public let data: Data
//}
