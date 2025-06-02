//
//  RecipeImageViewModel.swift
//  Recipe
//
//  Created by Edward Lie on 5/30/25.
//

import Foundation
import Observation

@Observable @MainActor
final class RecipeImageViewModel {
    private(set) var imageFetchStatus: FetchStatus<Data, Error> = .idle
    private(set) var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func fetchImage() {
        Task {
            do {
                imageFetchStatus = .fetching
                guard let url = recipe.photoUrlLarge, !url.isEmpty else {
                    imageFetchStatus = .idle
                    return
                }
                let imageUrlData = try await ImageCache.shared.fetchImage(filePath: url)
                if imageUrlData.isEmpty {
                    imageFetchStatus = .idle
                } else {
                    imageFetchStatus = .successful(data: imageUrlData)
                }
            } catch {
                imageFetchStatus = .error(error)
            }
        }
    }
}
