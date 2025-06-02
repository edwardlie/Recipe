//
//  MockRecipeListResponse.swift
//  Recipe
//
//  Created by Edward Lie on 5/30/25.
//

import Foundation

#if DEBUG
@MainActor
struct MockRecipeListResponse {
    func fetchRecipeList(fileName: String) async throws -> [Recipe]? {
        let localRecipeListFetcher = LocalRecipeListFetcher(fileName: fileName)
        let recipeListRequest = RecipeListRequest()
        let response = try? await localRecipeListFetcher.fetchRecipeList(request: recipeListRequest)
        guard let result = response?.recipes else {
            return nil
        }
        return result
    }
}
#endif
