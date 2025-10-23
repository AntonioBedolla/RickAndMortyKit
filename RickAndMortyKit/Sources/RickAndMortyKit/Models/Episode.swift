//
//  File.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import Foundation

public struct Episode: Identifiable, Codable, Equatable {
  public let id: Int
  public let name: String
  public let episode: String
  public var isWatchedd: Bool = false
}
