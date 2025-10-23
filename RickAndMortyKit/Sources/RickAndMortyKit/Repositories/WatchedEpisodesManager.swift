//
//  File.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import Foundation
import Combine

public final class WatchedEpisodesManager {
    
    private let key = "watchedEpisodes"
    static let shared = WatchedEpisodesManager()

    private init() {}
    

    //  Obtener todos los episodios vistos
        func getWatchedEpisodes() -> [Int] {
            UserDefaults.standard.array(forKey: key) as? [Int] ?? []
        }

        // Saber si un episodio está visto
        func isWatched(id: Int) -> Bool {
            getWatchedEpisodes().contains(id)
        }

        // Alternar estado (visto / no visto)
        func toggleWatched(id: Int) {
            var watched = getWatchedEpisodes()
            if let index = watched.firstIndex(of: id) {
                watched.remove(at: index) // ya estaba → lo quitamos
            } else {
                watched.append(id) // no estaba → lo agregamos
            }
            UserDefaults.standard.set(watched, forKey: key)
        }
}
