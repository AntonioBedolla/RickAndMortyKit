//
//  File.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import Foundation
import MapKit
import CoreLocation

public struct MapLocation: Identifiable {
    
    public let id = UUID()
    public let coordinate: CLLocationCoordinate2D
    
    public static let example = MapLocation(coordinate: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437))
}

//Esto permite crear un MapLocation directamente desde un Character
extension MapLocation {
    init(from character: Character) {
            self.init(coordinate: character.simulatedCoordinate)
        }
}
