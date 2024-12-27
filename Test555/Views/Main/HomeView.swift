//
//  HomeView.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject  var viewModel:RecipesViewModel
    @EnvironmentObject var nav:MoreNavigationManager
        var body: some View {
            ZStack{
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
                                .onTapGesture {
                                    viewModel.recipeId = recipe.id
                                    nav.loadView(.detail)
                                }
                        }
                    }
                }
                .onAppear{
                    Task {
                        await viewModel.fetchRecipes()
                    }
                }
                .navigationTitle("Recipes")
                .navigationBarBackButtonHidden(true)
            }
            .navigationBarBackButtonHidden(true)
        }
    

}
let previewViewModel = RecipesViewModel()
#Preview {
    HomeView()
        .environmentObject(navPreview)
        .environmentObject(previewViewModel)
}
