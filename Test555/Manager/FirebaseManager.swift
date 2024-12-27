//
//  ApiManager.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid:String
    let email:String
    let photoUrl:String
    init(user:User) {
        self.uid = user.uid
        self.email = user.email ?? ""
        self.photoUrl = user.photoURL?.absoluteString ?? ""
        
    }
}
import Firebase
import FirebaseStorage
import FirebaseFirestore
import Foundation

class FirebaseManager {
    
    static let shared = FirebaseManager()
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    // Create User
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)
        return result
    }
    
    // Sign In User
    func signUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)
        return result
    }
    
    // Sign Out
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    // Fetch user profile from Firestore
    func fetchUserProfile(userId: String) async throws -> [String: Any] {
        let docRef = db.collection("users").document(userId)
        let document = try await docRef.getDocument()
        guard let data = document.data() else {
            throw NSError(domain: "FirebaseManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "User data not found"])
        }
        return data
    }
    
    // Update User Profile in Firestore
    func updateUserProfile(userId: String, data: [String: Any]) async throws {
        let docRef = db.collection("users").document(userId)
        try await docRef.setData(data, merge: true)
    }
    
    // Upload Profile Image to Firebase Storage
    func uploadProfileImage(userId: String, imageData: Data) async throws -> String {
        let imageRef = storage.reference().child("profileImages/\(userId).jpg")
        
        _ = try await imageRef.putData(imageData, metadata: nil)
        let downloadURL = try await imageRef.downloadURL()
        return downloadURL.absoluteString
    }
}
