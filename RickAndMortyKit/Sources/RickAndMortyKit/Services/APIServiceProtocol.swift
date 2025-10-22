//
//  File.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import Foundation
import Combine

public protocol APIServiceProtocol {
    
    func fetchCharacters() -> AnyPublisher<[CharacterModel], Error>
}
