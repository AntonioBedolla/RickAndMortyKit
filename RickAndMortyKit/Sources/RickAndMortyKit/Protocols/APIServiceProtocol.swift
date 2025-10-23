//
//  File.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import Foundation
import Combine

public protocol APIServiceProtocol {
    func fetchCharacters(
        page: Int,
        name: String?,
        status: String?,
        species: String?,
        completion: @escaping (Result<CharacterAPIResponse, Error>) -> Void)
    
    func fetchEpisodes(urls: [String], completion: @escaping (Result<[Episode], Error>) -> Void)
}
