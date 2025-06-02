//
//  RecipeListViewModelTests.swift
//  RecipeTests
//
//  Created by Edward Lie on 5/30/25.
//

@testable import Recipe
import Testing
import Combine
import Foundation

enum TimeoutError: Error {
    case timeout
}

func waitForNonEmptyList(in viewModel: RecipeListViewModel, timeout: TimeInterval = 2.0) async throws {
    let start = Date()
    while Date().timeIntervalSince(start) < timeout {
        let status = await MainActor.run { viewModel.recipeListFetchStatus }
        if status.isError || status.isSuccessful {
            return
        }
        try await Task.sleep(for: .milliseconds(100))
    }
    
    throw TimeoutError.timeout
}

@Suite("Recipe List Tests")
@MainActor
struct RecipeListViewModelTests {

    @Test("Test Recipe List Populated")
    func recipeListPopulated() async throws {
        let viewModel = await createViewModel("Recipes.json")
        await viewModel.fetchRecipeList()
        try await waitForNonEmptyList(in: viewModel)
        #expect(!viewModel.recipeList.isEmpty)
    }
    
    @Test("Test Recipe List Populated")
    func recipeListNotPopulatedIfEmpty() async throws {
        let viewModel = await createViewModel("RecipesEmpty.json")
        await viewModel.fetchRecipeList()
        try await waitForNonEmptyList(in: viewModel)
        #expect(viewModel.recipeList.isEmpty)
        #expect(!viewModel.recipeListFetchStatus.isError)
    }
    
    @Test("Test Recipe List Malformed")
    func recipeListMalformed() async throws {
        let viewModel = await createViewModel("RecipesMalformed.json")
        await viewModel.fetchRecipeList()
        try await waitForNonEmptyList(in: viewModel)
        #expect(viewModel.recipeList.isEmpty)
        #expect(viewModel.recipeListFetchStatus.isError)
    }
}

private extension RecipeListViewModelTests {
    func createViewModel(_ fileName: String) async -> RecipeListViewModel {
        let viewModel = RecipeListViewModel(recipeListFetcher: LocalRecipeListFetcher(fileName: fileName))
        return viewModel
    }
}
