//
//  HomeDetailView.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//

import SwiftUI


struct RecipeDetailView: View {
    @EnvironmentObject  var viewModel:RecipesViewModel
    let recipeId: Int

    var body: some View {
        ZStack{
            
                if viewModel.isLoading {
                    ProgressView("Loading Recipe...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                } else if let recipe = viewModel.recipe {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            AsyncImage(url: URL(string: recipe.image)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Text(recipe.name)
                                .font(.title)
                                .bold()
                            
                            Text("Cuisine: \(recipe.cuisine)")
                                .font(.subheadline)
                            
                            Text("Difficulty: \(recipe.difficulty)")
                                .font(.subheadline)
                            
                            Text("Prep Time: \(recipe.prepTimeMinutes) mins | Cook Time: \(recipe.cookTimeMinutes) mins")
                                .font(.subheadline)
                            
                            Text("Servings: \(recipe.servings)")
                                .font(.subheadline)
                            
                            Text("Calories Per Serving: \(recipe.caloriesPerServing)")
                                .font(.subheadline)
                            
                            Text("Rating: \(recipe.rating) (\(recipe.reviewCount) reviews)")
                                .font(.subheadline)
                            
                            Divider()
                            
                            Text("Ingredients")
                                .font(.headline)
                            ForEach(recipe.ingredients, id: \.self) { ingredient in
                                Text("- \(ingredient)")
                            }
                            
                            Divider()
                            
                            Text("Instructions")
                                .font(.headline)
                            ForEach(recipe.instructions, id: \.self) { instruction in
                                Text("\(instruction)")
                                    .padding(.bottom, 5)
                            }
                        }
                        .padding()
                    }
                } else {
                    Text("Recipe not found")
                        .foregroundColor(.gray)
                }
            
        }
        .navigationTitle("Recipe Details")
        .onAppear{
            Task {
                await viewModel.fetchRecipe(by: recipeId)
            }
        }
    }
}


#Preview {
    RecipeDetailView(recipeId: 1)
}
