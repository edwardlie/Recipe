//
//  HomeView.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import SwiftUI

public func openUrl(_ urlString: String) {
    guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else { return }
    UIApplication.shared.open(url)
}

struct RecipeListView: View {
    @State var recipeListViewModel: RecipeListViewModel
    
    init(recipeListViewModel: RecipeListViewModel) {
        _recipeListViewModel = State(initialValue: recipeListViewModel)
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                List(recipeListViewModel.recipeList, id: \.uuid ) { recipe in
                    RecipeImageView                            	(viewModel: RecipeImageViewModel(recipe: recipe))
                        .onTapGesture {
                            if let sourceUrl = recipe.sourceUrl {
                                openUrl(sourceUrl)
                            }
                        }
                        .listRowSeparator(.hidden)
                }
                .padding()
                
                if recipeListViewModel.recipeListFetchStatus.isError {
                    ContentUnavailableView {
                        Label("Error Fetching Recipes", systemImage: "xmark.octagon.fill")
                    }
                } else if recipeListViewModel.recipeList.isEmpty && !recipeListViewModel.recipeListFetchStatus.isFetching {
                    ContentUnavailableView {
                        Label("No Recipes Found", systemImage: "doc.richtext.fill")
                    }
                }
            }
            .background(.recipeListBackground)
            .navigationTitle("Recipes")
            .progressOverlay(showProgress: recipeListViewModel.recipeListFetchStatus.isFetching && !recipeListViewModel.isRefreshing)
            .task {
                await recipeListViewModel.fetchRecipeList()
            }
            .refreshable {
                await recipeListViewModel.fetchRecipeList(isRefreshing: true)
            }
        }
    }
}

#Preview {
    RecipeListView(recipeListViewModel: RecipeListViewModel(recipeListFetcher: LocalRecipeListFetcher()))
}
