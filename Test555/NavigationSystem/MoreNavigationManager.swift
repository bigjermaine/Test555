//
//  MoreNavigationManager.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//


import Foundation
import SwiftUI

class MoreNavigationManager: ObservableObject {
    @Published var path: [MoreRoutes] = []
    @Published var isValidated = false {
            didSet {
                UserDefaults.standard.set(isValidated, forKey: "isValidatedKey")
            }
        }
    
    init() {
        if let savedValue = UserDefaults.standard.value(forKey: "isValidatedKey") as? Bool {
            isValidated = savedValue
            if isValidated {
                path.append(.mainView)
            }else {
                path.append(.login)
            }
        }
    
    }
    
    func updateValidation(success: Bool) {
        withAnimation {
            DispatchQueue.main.async { [weak self] in
                self?.isValidated = success
                UserDefaults.standard.set(self?.isValidated, forKey: "isValidatedKey")
            }
            
        }
    }
    enum MoreRoutes: Hashable {
        case login
        case registration
        case mainView
        case password
    }
    
   

    func goToRoot() {
        path.removeAll()
    }

  func goBack() {
      path.removeLast()
  }

   
    func loadView(_ item: MoreRoutes) {
        switch item {
        case .login:
            updateValidation(success: false)
        case .registration:
            updateValidation(success: false)
        case .mainView:
            updateValidation(success: true)
        case .password:
            updateValidation(success: true)
        }
        path.append(item)
    }

    func swapView(_ item: MoreRoutes) {
        path.removeLast()
        path.append(item)
    }

    func replaceStack(_ item: MoreRoutes) {
        path.removeAll()
        Task { @MainActor in
            // The time delay may be device/app specific.
            try? await Task.sleep(nanoseconds: 400_000_000)
            loadView(item)
        }
    }
}


