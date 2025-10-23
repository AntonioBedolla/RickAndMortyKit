//
//  SwiftUIView.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import SwiftUI
import LocalAuthentication

public struct FavoritesView: View {
    @State private var authenticated = false
    @State private var showError = false
    @State private var errorMessage: String = ""
    @StateObject private var favoritesManager = FavoritesManager.shared
    @State private var characters: [Character] = []
    @State private var isLoading = true
    public init() {}
    
   public var body: some View {
       NavigationView {
           Group {
               if !authenticated {
                   Text("Autenticación requerida")
                       .onAppear(perform: authenticate)
               } else if isLoading {
                   ProgressView()
               } else if characters.isEmpty {
                   Text("No hay personajes favoritos.")
               } else {
                   List(characters) { character in
                       NavigationLink(destination: CharacterDetailView(character: character)) {
                           CharacterRow(character: character)
                       }
                   }
               }
           }
           .navigationTitle("Favoritos")
           .alert(isPresented: $showError) {
               Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
           }
       }
       .onAppear {
           if authenticated {
               loadFavoriteCharacters()
           }
       }
   }

   private func authenticate() {
       let context = LAContext()
       var error: NSError?

       if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
           context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Accede a tus personajes favoritos") { success, authError in
               DispatchQueue.main.async {
                   if success {
                       self.authenticated = true
                       self.loadFavoriteCharacters()
                   } else {
                       self.errorMessage = "Autenticación fallida"
                   }
               }
           }
       } else {
           errorMessage = "Face ID / Touch ID no disponible"
       }
   }

   private func loadFavoriteCharacters() {
       let ids = favoritesManager.favoriteIDs
       guard !ids.isEmpty else {
           self.characters = []
           self.isLoading = false
           return
       }

       // Fetch characters en lote (Rick and Morty API permite ?ids=1,2,3)
       let idString = ids.map(String.init).joined(separator: ",")
       let urlStr = "https://rickandmortyapi.com/api/character/\(idString)"

       guard let url = URL(string: urlStr) else { return }

       URLSession.shared.dataTask(with: url) { data, _, error in
           DispatchQueue.main.async {
               self.isLoading = false
               guard let data = data, error == nil else {
                   self.errorMessage = "Error cargando personajes"
                   return
               }

               do {
                   if ids.count == 1 {
                       let character = try JSONDecoder().decode(Character.self, from: data)
                       self.characters = [character]
                   } else {
                       self.characters = try JSONDecoder().decode([Character].self, from: data)
                   }
               } catch {
                   self.errorMessage = "Error decodificando personajes"
               }
           }
       }.resume()
    }
}
