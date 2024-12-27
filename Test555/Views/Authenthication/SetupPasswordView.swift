//
//  SetupPasswordView.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//


import SwiftUI

struct SetupPasswordView: View {
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
                        Text("Password")
                            .foregroundStyle(.white)
                        HStack{
                            SecretCustomTextField(text: $registerVM.password, placeholder: "Enter Password Here", backgroundColor: .color161618, cornerRadius: 12, textColor: .white, placeholderColor: .color7A7A7A)
                        }
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    VStack(alignment:.leading){
                        Text("Confirm Password")
                            .foregroundStyle(.white)
                        HStack{
                            SecretCustomTextField(text: $registerVM.confirmPassword, placeholder: "Confirm Your Password", backgroundColor: .color161618, cornerRadius: 12, textColor: .white, placeholderColor: .color7A7A7A)
                        }
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    Spacer()
                    Button(action: {
                        Task{
                            registerVM.registerUser()
                        }
                            if registerVM.isRegistrationSuccessful {
                                nav.loadView(.mainView)
                            }
            
                    }) {
                        Text("Submit")
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
            .onChange(of: registerVM.isRegistrationSuccessful) { isSuccessful in
                nav.loadView(.mainView)
            }
            .alert(isPresented:$registerVM.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(registerVM.errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
       }
  
#Preview {
    SetupPasswordView()
        .environmentObject(registerVMPreview)
        .environmentObject(navPreview)
}

extension SetupPasswordView {
    var header: some View {
        VStack(alignment: .leading,spacing: 8){
            HStack{
                Text("Setup your ")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                Text("Password")
                    .font(.title)
                    .foregroundColor(.color0077FF)
                    .bold()
            }
          
        }
    }
}
