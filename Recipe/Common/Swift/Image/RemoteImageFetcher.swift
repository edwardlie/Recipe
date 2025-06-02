//
//  RemoteImageFetcher.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import Foundation
import SwiftUICore
import UIKit

struct RemoteImageFetcher: ImageFetcherProtocol {
    func fetchImage(filePath: String) async throws -> Data {
        let data = try await NetworkManager.shared.performRawRequest(
               request: ImageRequest(request: ImageModelRequest(filePath: filePath))
           )
        
        guard let _ = UIImage(data: data) else {
            throw ImageError.serverError
        }
        return data
    }
}
