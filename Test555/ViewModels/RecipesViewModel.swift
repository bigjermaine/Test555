//
//  RecipesViewModel.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//


import Foundation


class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var recipe: Recipe?
    @Published var  recipeId: Int = 1
    
    @MainActor
    func fetchRecipes() async {
        isLoading = true
        errorMessage = nil
        do {
            let recipesResponse = try await ApiManager.shared.fetchRecipes()
            recipes = recipesResponse.recipes
        } catch {
            errorMessage = "Failed to fetch recipes: \(error.localizedDescription)"
        }
        isLoading = false
    }
    @MainActor
    func fetchRecipe(by id: Int) async {
        isLoading = true
        errorMessage = nil
        do {
            recipe = try await ApiManager.shared.fetchRecipeById(id: recipeId)
        } catch {
            errorMessage = "Failed to fetch recipe: \(error.localizedDescription)"
        }
        isLoading = false
    }

    
}
