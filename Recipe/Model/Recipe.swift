//
//  Recipe.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import Foundation

struct RecipeResponse: Decodable, Equatable {
    let recipes: [Recipe]
    
    static func == (lhs: RecipeResponse, rhs: RecipeResponse) -> Bool {
        lhs.recipes == rhs.recipes
    }
}

struct Recipe: Decodable, Equatable {
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let uuid: String
    let youtubeUrl: String?
}

extension Recipe: Identifiable {
    var id: String { uuid }
}

extension Recipe: Hashable { }
