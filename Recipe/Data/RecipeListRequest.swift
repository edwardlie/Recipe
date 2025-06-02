//
//  RecipeListRequest.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import Foundation

@MainActor
struct RecipeListRequest: RequestProtocol {
    var path: String {
        "/recipes.json"
    }
    
    var requestType: RequestType {
        .get
    }
}
