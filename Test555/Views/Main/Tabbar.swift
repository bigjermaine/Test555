//
//  Tabbar.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//

import SwiftUI


struct Tabbar: View {
    @EnvironmentObject var nav:MoreNavigationManager
    @EnvironmentObject private var registerVM:RegisterViewModel
    @EnvironmentObject private var viewModel:RecipesViewModel
    var body: some View {
        TabView {
            HomeView()
                .environmentObject(nav)
                .environmentObject(viewModel)
                .environmentObject(registerVM)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
            
         .navigationBarBackButtonHidden()
        }
        .navigationBarBackButtonHidden(true)
       
    }
}

#Preview {
    Tabbar()
        .environmentObject(registerVMPreview)
        .environmentObject(navPreview)
}
