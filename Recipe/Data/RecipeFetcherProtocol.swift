//
//  RecipeFetcherProtocol.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import Foundation

@MainActor
protocol RecipeListFetcherProtocol {
    func fetchRecipeList(request: RecipeListRequest) async throws -> RecipeResponse
}
