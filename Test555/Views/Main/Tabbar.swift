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
    var body: some View {
        TabView {
            HomeView()
                .environmentObject(nav)
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
       
    }
}

#Preview {
    Tabbar()
        .environmentObject(registerVMPreview)
        .environmentObject(navPreview)
}
