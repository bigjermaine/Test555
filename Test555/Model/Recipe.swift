//
//  Recipe.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//


import Foundation

// Define the data models based on the API response
struct Recipe: Decodable,Identifiable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let prepTimeMinutes: Int
    let cookTimeMinutes: Int
    let servings: Int
    let difficulty: String
    let cuisine: String
    let caloriesPerServing: Int
    let tags: [String]
    let userId: Int
    let image: String
    let rating: Double
    let reviewCount: Int

}

struct RecipesResponse: Decodable {
    let recipes: [Recipe]
    let total: Int
    let skip: Int
    let limit: Int
}

