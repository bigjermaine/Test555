//
//  SignUpView.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//
import SwiftUI



struct CreateAccountView: View {
    @State private var email: String = ""
    @State private var userName: String = ""
    @StateObject private var nav = MoreNavigationManager()
    @StateObject private var registerVM  = RegisterViewModel()
    @StateObject private var viewModel = RecipesViewModel()
    var body: some View {
        NavigationStack(path: $nav.path) {
            ZStack{
                Color.black.ignoresSafeArea()
                if registerVM.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(5)
                    }
                ScrollView{
                    VStack(alignment: .leading, spacing: 14) {
                        header
                        VStack(alignment:.leading){
                            Text("Email Address")
                                .foregroundStyle(.white)
                            HStack{
                                CustomTextField(text: $registerVM.email, placeholder: "Enter Email Here", backgroundColor: .color161618, cornerRadius: 12, textColor: .white, placeholderColor: .color7A7A7A)
                            }
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top,46)
                        VStack(alignment:.leading){
                            Text("User Name")
                                .foregroundStyle(.white)
                            HStack{
                                CustomTextField(text: $registerVM.userName, placeholder: "Enter user name here", backgroundColor: .color161618, cornerRadius: 12, textColor: .white, placeholderColor: .color7A7A7A)
                            }
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        
                        HStack {
                            Spacer()
                            Text("OR")
                                .font(.caption)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            Text("Use Your OpenID")
                                .foregroundStyle(.white)
                                .font(.caption)
                            Spacer()
                        }
                        
                        HStack{
                            HStack{
                                
                            }
                            .frame(width: 111,height: 88)
                            .background(.color161618)
                            .cornerRadius(10)
                            HStack{
                                
                            }
                            .frame(width: 111,height: 88)
                            .background(.color161618)
                            .cornerRadius(10)
                            HStack{
                                
                            }
                            .frame(width: 111,height: 88)
                            .background(.color161618)
                            .cornerRadius(10)
                        }
                        
                        
                            HStack{
                                Spacer()
                                Text("Already have an account?")
                                    .foregroundColor(.white)
                                 
                                Text("login")
                                    .foregroundColor(.colorFFC700)
                                Spacer()
                            }
                            .onTapGesture {
                                nav.path.append(.login)
                            }
                        
                        
                        Button(action: {
                            nav.path.append(.password)
                        }) {
                            Text("Next")
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.colorFFC700)
                                .cornerRadius(8)
                        }
                        Spacer()
                    }
                    .padding(16)
                }
            }
            .navigationDestination(for: MoreNavigationManager.MoreRoutes.self) { route in
                switch route {
                case.registration:
                    CreateAccountView()
                        .environmentObject(nav)
                        .environmentObject(registerVM)
                case.login:
                    LoginView()
                        .environmentObject(nav)
                        .environmentObject(registerVM)
                case.password:
                    SetupPasswordView()
                        .environmentObject(nav)
                        .environmentObject(registerVM)
                case.mainView:
                    Tabbar()
                        .environmentObject(nav)
                        .environmentObject(viewModel)
                        .environmentObject(registerVM)
                default:
                    EmptyView()
                }
            }
        }
        
    }
       }
    
#Preview {
    CreateAccountView()
        .environmentObject(registerVMPreview)
        .environmentObject(navPreview)
}

extension CreateAccountView {
    var header: some View {
        VStack(alignment: .leading,spacing: 8){
            HStack{
                Text("Create")
                    .foregroundColor(.color0077FF)
                    .font(.title)
                    .bold()
                Text("new account")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
            }
            Text("Set up a new account using your email address.")
                .foregroundColor(.white)
                .font(.body)
        }
    }
}
