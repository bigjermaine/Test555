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
  class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    
    func createUser(email: String, password: String) async throws ->  AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)
        return result
      }
      
      func signUser(email: String, password: String) async throws ->  AuthDataResultModel {
          let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
          let result = AuthDataResultModel(user: authDataResult.user)
          return result
        }
      
      func signOut()  throws {
          try  Auth.auth().signOut()
      }
    
}
