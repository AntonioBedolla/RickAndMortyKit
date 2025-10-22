//
//  File.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import Foundation

public struct CharacterModel: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let species: String
    public let status: String
    public let image: String

    public init(id: Int, name: String, species: String, status: String, image: String) {
        self.id = id
        self.name = name
        self.species = species
        self.status = status
        self.image = image
    }
}
