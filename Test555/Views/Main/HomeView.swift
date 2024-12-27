//
//  HomeView.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//

import SwiftUI

struct HomeView: View {
 
        @StateObject private var viewModel = RecipesViewModel()

        var body: some View {
            NavigationView {
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading Recipes...")
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    } else {
                        List(viewModel.recipes) { recipe in
                            RecipeRow(recipe: recipe)
                        }
                    }
                }
                .onAppear{
                    Task {
                        await viewModel.fetchRecipes()
                    }
                }
                .navigationTitle("Recipes")
                .navigationBarBackButtonHidden()
            }
            
        }
    

}

#Preview {
    HomeView()
}
