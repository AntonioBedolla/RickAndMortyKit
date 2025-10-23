//
//  SwiftUIView.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import SwiftUI
import MapKit

public struct MapView: View {
    let location: MapLocation
    
        @State private var region: MKCoordinateRegion

       public init(location: MapLocation) {
            self.location = location
            _region = State(initialValue: MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            ))
        }
    
   public var body: some View {
       Map(coordinateRegion: $region, annotationItems: [location]) { loc in
           MapMarker(coordinate: loc.coordinate, tint: .blue)
       }
       .navigationTitle("Ubicación")
       .navigationBarTitleDisplayMode(.inline)
    }
}
