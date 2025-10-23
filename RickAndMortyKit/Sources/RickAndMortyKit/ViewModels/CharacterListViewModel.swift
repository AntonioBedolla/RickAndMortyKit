//
//  File.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import Foundation
import Combine

public final class CharacterListViewModel: ObservableObject {
    
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var error: String?
    @Published var hasMore: Bool = true

  // Filtros
    @Published var searchText: String = ""
    @Published var selectedStatus: String = ""
    @Published var selectedSpecies: String = ""

    private var currentPage = 1

    private let apiService: APIServiceProtocol

   public init(apiService: APIServiceProtocol) {
        self.apiService = apiService
        fetchCharacters(reset: true)
    }

func fetchCharacters(reset: Bool = false) {
        guard !isLoading else { return }
        
        if reset {
            characters = []
            currentPage = 1
            hasMore = true
        }
        guard hasMore else { return }
        isLoading = true

    apiService.fetchCharacters(
                page: currentPage,
                name: searchText,
                status: selectedStatus,
                species: selectedSpecies
            ) { [weak self] result in
                DispatchQueue.main.async {
                    self?.isLoading = false

                    switch result {
                    case .success(let charactersPage):
                        if charactersPage.results.isEmpty {
                            self?.hasMore = false
                        } else {
                            self?.characters += charactersPage.results
                            self?.currentPage += 1
                        }
                    case .failure(let error):
                        self?.error = error.localizedDescription
                    }
                }
            }
    }

func applyFilters() {
        fetchCharacters(reset: true)
    }

func refresh() {
    applyFilters()
}
}
