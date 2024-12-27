//
//  LoginView.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var userName: String = ""
    @EnvironmentObject var nav:MoreNavigationManager
    @EnvironmentObject private var registerVM:RegisterViewModel
    var body: some View {
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
                    
                    VStack(alignment:.leading){
                        Text("Password")
                            .foregroundStyle(.white)
                        HStack{
                            SecretCustomTextField(text: $registerVM.password, placeholder: "Enter Password Here", backgroundColor: .color161618, cornerRadius: 12, textColor: .white, placeholderColor: .color7A7A7A)
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
                    
                 
             
                    HStack{
                        Spacer()
                        Text("Already have an account?")
                            .foregroundColor(.white)
                        Text("Sign Up")
                            .foregroundColor(.colorFFC700)
                        Spacer()
                    }
                        .onTapGesture {
                            nav.path.removeAll()
                        }
                    
                    
                    Button(action: {
                        Task{
                            registerVM.loginUser()
                        }
                            if registerVM.isRegistrationSuccessful {
                                nav.loadView(.mainView)
                            }
                        
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
                .alert(isPresented: $registerVM.showAlert) {
                               Alert(title: Text("Error"), message: Text(registerVM.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                           }
            }
        }
        .onChange(of: registerVM.isRegistrationSuccessful) { isSuccessful in
            nav.loadView(.mainView)
        }
        .navigationBarBackButtonHidden()
    }
       }
    
let registerVMPreview = RegisterViewModel()
let navPreview = MoreNavigationManager()
#Preview {
    LoginView()
        .environmentObject(registerVMPreview)
        .environmentObject(navPreview)
    
       
}

extension LoginView {
    var header: some View {
        VStack(alignment: .leading,spacing: 8){
            HStack{
                Text("Login")
                    .foregroundColor(.color0077FF)
                    .font(.title)
                    .bold()
                Text("Your Account")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
            }
            Text("Enter your email address to login to your account.")
                .foregroundColor(.white)
                .font(.body)
        }
    }
}
