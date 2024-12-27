//
//  RegisterViewModel.swift
//  JIVApp
//
//  Created by MacBook AIR on 13/12/2024.
//


import Foundation

import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var userName: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var otpCode: String = ""
    @Published var isRegistrationSuccessful: Bool = false // For navigation
    @Published var isChangePassword: Bool = false // For navigation
    @Published var isChangeEmailPassword: Bool = false // For navigation
    @Published var isOTPVerified: Bool = false // For OTP verification status
    @Published var isLoginSuccessful: Bool = false

    
    @MainActor
    func registerUser()  {
        isLoading = true
        Task{
            do {
                let returnedUser =   try await FirebaseManager.shared.createUser(email: email, password: password)
                isRegistrationSuccessful = true
                isLoading = false
            }catch let error {
                isLoading = false
                showAlert = true
                errorMessage = error.localizedDescription
             
            }
        }
    }
    @MainActor
    func verifyOTP() async {
    
    }
    
    @MainActor
    func signOut() async {
        do {
            try FirebaseManager.shared.signOut()
        }catch let error {
            isLoading = false
            showAlert = true
            errorMessage = error.localizedDescription
        }
    }
    @MainActor
    func resendOTP() async {

    }
    
    @MainActor
    func loginUser()  {
        Task{
            do {
                let returnedUser =  try await  FirebaseManager.shared.signUser(email: email, password: password)
                print(returnedUser)
                isRegistrationSuccessful = true
                isLoading = false
            }catch let error {
                isRegistrationSuccessful = true
                isLoading = false
                showAlert = true
                errorMessage = error.localizedDescription
            }
        }
      }
    
    @MainActor
    func forgotPassword() async {
        
      }
    
    @MainActor
    func changePassword() async {
       
      }
    
    private func displayError(_ message: String) {
        errorMessage = message
        showAlert = true
    }
}
