//
//  File.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import Foundation
import CoreLocation

public struct Character: Identifiable, Decodable, Equatable {
   public let id: Int
   public let name: String
   public let status: String
   public let species: String
   public let type: String
   public let gender: String
   public let origin: Origin
   public let location: LocationInfo
   public let image: String
   public let episode: [String]
    
   public struct Origin: Decodable, Equatable {
        let name: String
    }

   public struct LocationInfo: Decodable, Equatable {
        let name: String
    }
}

extension Character {
    var simulatedCoordinate: CLLocationCoordinate2D {
        // Simulación simple basada en el ID
        let baseLat = 19.4326    // CDMX lat
        let baseLong = -99.1332  // CDMX long

        // Usa el ID para desplazamiento
        let latOffset = Double((id % 10)) * 0.01
        let longOffset = Double((id % 10)) * 0.01

        return CLLocationCoordinate2D(latitude: baseLat + latOffset, longitude: baseLong + longOffset)
    }
}
