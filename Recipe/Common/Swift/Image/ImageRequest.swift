//
//  ImageRequest.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import Foundation

@MainActor
struct ImageRequest: RequestProtocol {
    private(set) var request: ImageModelRequest
    
    init(request: ImageModelRequest) {
        self.request = request
    }
    
    var path: String {
        if let range = request.filePath.range(of: "/photos/") {
            let photoPath = request.filePath[range.upperBound...]
            return "/photos/\(photoPath)"
        }
        return ""
    }
    
    var requestType: RequestType {
        .get
    }
}
