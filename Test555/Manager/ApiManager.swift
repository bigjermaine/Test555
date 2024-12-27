//
//  ApiManager.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//

import Foundation

class ApiManager {
    static let shared  = ApiManager()
    
    
    func fetchRecipes() async throws -> RecipesResponse {
        // Define the API URL
        let urlString = "https://dummyjson.com/recipes"
        
        // Validate the URL
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // Create and configure the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Make the network request
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // Decode the JSON response
        let recipesResponse = try JSONDecoder().decode(RecipesResponse.self, from: data)
        
        // Return the decoded response
        return recipesResponse
    }
    
    
    func fetchRecipeById(id: Int) async throws -> Recipe {
        let urlString = "https://dummyjson.com/recipes/\(id)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Recipe.self, from: data)
    }
}

