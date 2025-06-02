//
//  RemoteRecipeListFetcher.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import Foundation

struct RemoteRecipeListFetcher: RecipeListFetcherProtocol {
    func fetchRecipeList(request: RecipeListRequest) async throws -> RecipeResponse {
        try await NetworkManager.shared.performRequest(request: request)
    }
}
