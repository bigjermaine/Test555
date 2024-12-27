//
//  RegisterViewModel.swift
//  JIVApp
//
//  Created by MacBook AIR on 13/12/2024.
//


import Foundation
import Firebase
import FirebaseAuth
import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var profileImage: Image?
    @Published var imageData: Data?
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
    private let firebaseManager = FirebaseManager.shared
        private var currentUserId: String?
    init() {
          fetchUserProfile()
      }
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
    
    // Fetch the current user's profile from Firestore
        func fetchUserProfile() {
            guard let user = Auth.auth().currentUser else {
                errorMessage = "User is not logged in"
                return
            }
            
            currentUserId = user.uid
            Task {
                do {
                    let userProfile = try await firebaseManager.fetchUserProfile(userId: user.uid)
                    self.name = userProfile["name"] as? String ?? ""
                    self.email = userProfile["email"] as? String ?? ""
                    if let imageUrl = userProfile["profileImageUrl"] as? String {
                        loadProfileImage(from: imageUrl)
                    }
                } catch {
                    errorMessage = error.localizedDescription
                }
            }
        }
        
        // Load profile image from a URL
        private func loadProfileImage(from url: String) {
            guard let imageUrl = URL(string: url) else { return }
            
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        self.profileImage = Image(uiImage: UIImage(data: data)!)
                    }
                }
            }.resume()
        }
        
        // Update user profile (name, email, profile image)
        func updateProfile() {
            guard let user = Auth.auth().currentUser else {
                errorMessage = "User is not logged in"
                return
            }
            
            isLoading = true
            var updatedData: [String: Any] = ["name": name, "email": email]
            
            // Upload profile image if new image data is provided
            if let imageData = imageData {
                Task {
                    do {
                        let imageUrl = try await firebaseManager.uploadProfileImage(userId: user.uid, imageData: imageData)
                        updatedData["profileImageUrl"] = imageUrl
                        
                        // Update Firestore with new data
                        try await firebaseManager.updateUserProfile(userId: user.uid, data: updatedData)
                        isLoading = false
                    } catch {
                        errorMessage = error.localizedDescription
                        isLoading = false
                    }
                }
            } else {
                // Update Firestore without image
                Task {
                    do {
                        try await firebaseManager.updateUserProfile(userId: user.uid, data: updatedData)
                        isLoading = false
                    } catch {
                        errorMessage = error.localizedDescription
                        isLoading = false
                    }
                }
            }
        }
    private func displayError(_ message: String) {
        errorMessage = message
        showAlert = true
    }
}
