//
//  RecipesViewModel.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//


import Foundation

@MainActor
class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

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

    
}
