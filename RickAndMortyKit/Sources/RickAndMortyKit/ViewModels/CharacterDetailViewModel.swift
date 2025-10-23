//
//  File.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import Foundation
import Combine

public final class CharacterDetailViewModel: ObservableObject {
    
    @Published var episodes: [Episode] = []
        @Published var isLoading = false
        @Published var error: String?

        private let apiService: APIServiceProtocol
        private let character: Character
        private let watchedManager = WatchedEpisodesManager.shared

       public init(character: Character, apiService: APIServiceProtocol) {
            self.character = character
            self.apiService = apiService
            fetchEpisodes()
        }

        func fetchEpisodes() {
            isLoading = true
            apiService.fetchEpisodes(urls: character.episode) { [weak self] result in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    switch result {
                    case .success(let episodes):
                        self?.episodes = episodes.sorted(by: { $0.id < $1.id })
                    case .failure(let error):
                        self?.error = error.localizedDescription
                    }
                }
            }
        }
    
    // Marcar/desmarcar episodio como visto
    func toggleWatched(_ episode: Episode) {
        watchedManager.toggleWatched(id: episode.id)
        objectWillChange.send() // Forzar actualización en la vista
    }
    
    // Saber si un episodio esta visto
    func isWatched(_ episode: Episode) -> Bool {
        watchedManager.isWatched(id: episode.id)
    }
}
