//
//  FavoritesManager.swift
//  Test555
//
//  Created by MacBook AIR on 27/12/2024.
//


import Foundation

class FavoritesManager {
    private let userDefaultsKey = "favoriteRecipeIDs"

    static let shared = FavoritesManager()

    private init() {}

    func saveFavorite(_ id: Int) {
        var favorites = getFavorites()
        if !favorites.contains(id) {
            favorites.append(id)
            UserDefaults.standard.set(favorites, forKey: userDefaultsKey)
        }
    }

    func removeFavorite(_ id: Int) {
        var favorites = getFavorites()
        if let index = favorites.firstIndex(of: id) {
            favorites.remove(at: index)
            UserDefaults.standard.set(favorites, forKey: userDefaultsKey)
        }
    }

    func getFavorites() -> [Int] {
        return UserDefaults.standard.array(forKey: userDefaultsKey) as? [Int] ?? []
    }

    func isFavorite(_ id: Int) -> Bool {
        return getFavorites().contains(id)
    }
}
