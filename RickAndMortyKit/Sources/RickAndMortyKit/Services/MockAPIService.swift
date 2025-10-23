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
    public func fetchCharacters(
            page: Int,
            name: String?,
            status: String?,
            species: String?,
            completion: @escaping (Result<CharacterAPIResponse, Error>) -> Void
        ) {
            let mockCharacter = Character(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Male",
                origin: .init(name: "Earth"),
                location: .init(name: "Citadel of Ricks"),
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                episode: ["https://rickandmortyapi.com/api/episode/1"]
            )
            
            let response = CharacterAPIResponse(
                        info: Info(next: nil),
                        results: [mockCharacter]
                    )

                    completion(.success(response))
        }

    public func fetchEpisodes(urls: [String], completion: @escaping (Result<[Episode], Error>) -> Void) {
            let mockEpisode = Episode(id: 1, name: "Pilot", episode: "S01E01")
            completion(.success([mockEpisode]))
        }
    }

