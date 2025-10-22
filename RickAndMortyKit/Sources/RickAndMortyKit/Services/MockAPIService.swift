//
//  File.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import Foundation
import Combine

public final class MockAPIService: APIServiceProtocol {
    
    public init() {}
    
    public func fetchCharacters() -> AnyPublisher<[CharacterModel], Error> {
        let mockData = [
            CharacterModel(id: 1, name: "Rick Sanchez", species: "Human", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
            CharacterModel(id: 2, name: "Morty Smith", species: "Human", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
        ]
        
        return Just(mockData)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}

