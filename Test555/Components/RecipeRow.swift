//
//  RecipeRow.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//

import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe

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
        }
    }
}
