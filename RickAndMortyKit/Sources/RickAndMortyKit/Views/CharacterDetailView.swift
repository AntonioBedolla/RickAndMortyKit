//
//  SwiftUIView.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import SwiftUI

public struct CharacterDetailView: View {
    
   public let character: Character
    @StateObject private var viewModel: CharacterDetailViewModel
    
   public init(character: Character) {
        self.character = character
        _viewModel = StateObject(wrappedValue: CharacterDetailViewModel(character: character, apiService: DependencyContainer.shared.apiService))
    }
    
   public var body: some View {
       ScrollView {
           VStack(spacing: 16) {
               // Imagen del personaje
               AsyncImage(url: URL(string: character.image)) { phase in
                   if let image = phase.image {
                       image
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                   } else {
                       Color.gray.frame(height: 200)
                   }
               }
               .frame(height: 300)
               .cornerRadius(12)

               // Datos principales
               VStack(alignment: .leading, spacing: 8) {
                   Text(character.name)
                       .font(.title)
                       .bold()

                   HStack {
                       Text("Estado:")
                       Text(character.status)
                           .bold()
                   }

                   HStack {
                       Text("Especie:")
                       Text(character.species)
                           .bold()
                   }

                   HStack {
                       Text("Género:")
                       Text(character.gender)
                           .bold()
                   }

                   HStack {
                       Text("Ubicación:")
                       Text(character.location.name)
                           .bold()
                   }
               }
               .frame(maxWidth: .infinity, alignment: .leading)
               .padding(.horizontal)

               // Placeholder para secciones siguientes
               Divider()

               Text("Episodios")
                   .font(.headline)
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .padding(.horizontal)

               // Lista de episodios
               Text("Episodios")
                   .font(.headline)
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .padding(.horizontal)

               if viewModel.isLoading {
                   ProgressView().padding()
               } else if let error = viewModel.error {
                   Text("Error al cargar episodios: \(error)").foregroundColor(.red)
               } else if viewModel.episodes.isEmpty {
                   Text("Este personaje no aparece en ningún episodio.")
                       .foregroundColor(.gray)
               } else {
                   ForEach(viewModel.episodes) { episode in
                       HStack {
                           VStack(alignment: .leading) {
                               Text(episode.name).font(.subheadline)
                               Text(episode.episode)
                                   .font(.caption)
                                   .foregroundColor(.secondary)
                           }
                           Spacer()
                           // Checkbox de "Visto"
                           Button(action: { viewModel.toggleWatched(episode)
                           }) {
                               Image(systemName: viewModel.isWatched(episode) ? "checkmark.square.fill" : "square")
                                   .foregroundColor(.blue)
                                   .font(.title2)
                           }
                           HStack {
                               Spacer()
                               Button(action: {
                                   FavoritesManager.shared.toggleFavorite(id: character.id)
                               }) {
                                   Image(systemName: FavoritesManager.shared.isFavorite(id: character.id) ? "heart.fill" : "heart")
                                       .foregroundColor(.red)
                                       .font(.title)
                               }
                               Spacer()
                           }
                       }
                       .padding(.horizontal)
                   }
               }

               // Botón de mapa
               NavigationLink(destination: MapView(location: MapLocation(from: character))) {
                   Label("Ver en mapa", systemImage: "map")
                       .frame(maxWidth: .infinity)
                       .padding()
                       .background(Color.blue.opacity(0.2))
                       .cornerRadius(10)
                       .padding(.horizontal)
               }
           }
           .padding(.bottom)
       }
       .navigationTitle("Detalle")
       .navigationBarTitleDisplayMode(.inline)
    }
}

