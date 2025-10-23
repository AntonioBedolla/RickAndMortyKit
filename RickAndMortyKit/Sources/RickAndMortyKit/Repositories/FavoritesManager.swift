//
//  File.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import Foundation
import Combine

public final class FavoritesManager: ObservableObject {
   public static let shared = FavoritesManager()

    @Published private(set) var favoriteIDs: Set<Int> = []

    private let key = "favorite_character_ids"

    private init() {
        loadFavorites()
    }

    func isFavorite(id: Int) -> Bool {
        favoriteIDs.contains(id)
    }

    func toggleFavorite(id: Int) {
        if favoriteIDs.contains(id) {
            favoriteIDs.remove(id)
        } else {
            favoriteIDs.insert(id)
        }
        saveFavorites()
    }

    private func saveFavorites() {
        let array = Array(favoriteIDs)
        UserDefaults.standard.set(array, forKey: key)
    }

    private func loadFavorites() {
        if let array = UserDefaults.standard.array(forKey: key) as? [Int] {
            favoriteIDs = Set(array)
        }
    }
}
