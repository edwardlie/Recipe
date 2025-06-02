//
//  RecipeApp.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import SwiftUI

@main
struct RecipeApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListView(recipeListViewModel: RecipeListViewModel(recipeListFetcher: RemoteRecipeListFetcher()))
        }
    }
}
