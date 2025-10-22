//
//  File.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import Foundation
import Combine

public final class CharacterListViewModel: ObservableObject {
    
    @Published public private(set) var characters: [CharacterModel] = []
    @Published public private(set) var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    private let service: APIServiceProtocol

    public init(service: APIServiceProtocol) {
        self.service = service
    }

    public func loadCharacters() {
        isLoading = true
        service.fetchCharacters()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] characters in
                self?.characters = characters
            }
            .store(in: &cancellables)
    }
}
