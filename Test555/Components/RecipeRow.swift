//
//  RecipeRow.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//

import SwiftUI
import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe
    @State private var isFavorite: Bool

    init(recipe: Recipe) {
        self.recipe = recipe
        self._isFavorite = State(initialValue: FavoritesManager.shared.isFavorite(recipe.id))
    }

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.image)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 5) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Button(action: {
                toggleFavorite()
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .gray)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

    private func toggleFavorite() {
        if isFavorite {
            FavoritesManager.shared.removeFavorite(recipe.id)
        } else {
            FavoritesManager.shared.saveFavorite(recipe.id)
        }
        isFavorite.toggle()
    }
}
#Preview {
    RecipeRow(recipe: Recipe(id: 1, name: "Test", ingredients: [], instructions: [], prepTimeMinutes: 0, cookTimeMinutes: 0, servings: 0, difficulty: "", cuisine: "", caloriesPerServing: 0, tags: [], userId: 0, image: "", rating: 0, reviewCount: 0))
}
