//
//  RecipeListViewModel.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import Foundation
import Observation

@Observable @MainActor
final class RecipeListViewModel {
    private(set) var recipeList: [Recipe] = []
    private(set) var recipeListFetcher: RecipeListFetcherProtocol
    var recipeListFetchStatus: FetchStatus<[Recipe]?, Error> = .idle
    private(set) var isRefreshing: Bool = false
    
    init(recipeListFetcher: RecipeListFetcherProtocol) {
        self.recipeListFetcher = recipeListFetcher
    }
    
    func fetchRecipeList(isRefreshing: Bool = false) async {
        let wasRefreshing = isRefreshing
        self.isRefreshing = isRefreshing
        recipeListFetchStatus = .fetching
        
        Task {
            do {
                recipeList = try await recipeListFetcher.fetchRecipeList(request: RecipeListRequest()).recipes
                if wasRefreshing {
                    self.isRefreshing = false
                }
                recipeListFetchStatus = .successful(data: recipeList)
            } catch {
                recipeListFetchStatus = .error(error)
            }
        }
    }
}
