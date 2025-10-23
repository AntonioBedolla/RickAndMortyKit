//
//  SwiftUIView.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import SwiftUI


public struct CharacterRow: View {
    let character: Character
    
   public var body: some View {
       HStack {
           AsyncImage(url: URL(string: character.image)) { phase in
               if let image = phase.image {
                   image
                       .resizable()
                       .aspectRatio(contentMode: .fill)
               } else {
                   Color.gray
               }
           }
           .frame(width: 60, height: 60)
           .clipShape(Circle())
           .clipped()

           VStack(alignment: .leading, spacing: 4) {
               Text(character.name)
                   .font(.headline)
               Text("\(character.species) • \(character.status)")
                   .font(.subheadline)
                   .foregroundColor(.secondary)
           }
       }
    }
}
