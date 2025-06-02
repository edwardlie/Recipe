//
//  RecipeImageView.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import SwiftUI

enum AnimationDirection {
    case left
    case right
}

struct AnimatedOverlay<Content: View>: View {
    let content: Content
    let direction: AnimationDirection
    @State private var offsetX: CGFloat
    
    init(direction: AnimationDirection = .left, @ViewBuilder content: () -> Content) {
        self.direction = direction
        self.content = content()
        switch direction {
        case .left:
            self._offsetX = State(initialValue: -UIScreen.main.bounds.width)
        case .right:
            self._offsetX = State(initialValue: UIScreen.main.bounds.width)
        }
    }
    
    var body: some View {
        content
            .offset(x: offsetX)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    offsetX = 0
                }
            }
    }
}

struct RecipeImageView: View {
    @State private var viewModel: RecipeImageViewModel
    
    init(viewModel: RecipeImageViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            switch viewModel.imageFetchStatus {
            case .idle:
                EmptyImageView()
            case .fetching:
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: UIScreen.main.bounds.height)
            case .successful(let imageData):
                if let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay(alignment: .topLeading) {
                            AnimatedOverlay {
                                Text(viewModel.recipe.cuisine)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .background(.black.opacity(0.6))
                                    .cornerRadius(8)
                                    .padding(10)
                            }
                        }
                        .overlay(alignment: .topTrailing) {
                            if let youtubeUrlString = viewModel.recipe.youtubeUrl {
                                Image(systemName: "play.circle.fill")
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .background(.black.opacity(0.6))
                                    .cornerRadius(8)
                                    .padding(10)
                                    .onTapGesture {
                                        openUrl(youtubeUrlString)
                                    }
                            }
                        }
                        .overlay(alignment: .bottomTrailing) {
                            AnimatedOverlay(direction: .right) {
                                Text(viewModel.recipe.name)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .background(.black.opacity(0.6))
                                    .cornerRadius(8)
                                    .padding(10)
                            }
                        }
                }
            case .error:
                ImageErrorView(error: ImageError.noData)
            }
        }
        .onAppear {
            viewModel.fetchImage()
        }
    }
}

#Preview {
    RecipeImageView(viewModel: RecipeImageViewModel(recipe: Recipe(cuisine: "Cuisine", name: "Food Name", photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg", photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ", uuid: "uuidpreview", youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg")))
}
