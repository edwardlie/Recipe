//
//  LocalRecipeListFetcher.swift
//  Recipe
//
//  Created by Edward Lie on 5/30/25.
//

import Foundation

struct LocalRecipeListFetcher: RecipeListFetcherProtocol {
    var fileName: String = "Recipes.json"
    
    func fetchRecipeList(request: RecipeListRequest) async throws -> RecipeResponse {
        try await Task.sleep(for: .seconds(1))
        return try Bundle.main.decode(RecipeResponse.self, from: fileName)
    }
}
