//
//  SwiftUIView.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import SwiftUI

public struct CharacterListView: View {
    @StateObject private var viewModel: CharacterListViewModel
    
    let statuses = ["", "alive", "dead", "unknown"]
    let speciesList = ["", "Human", "Alien", "Robot", "Mythological", "Animal"]
    
    // Este init permite inyectar un ViewModel (usado en preview o App)
   public init(viewModel: CharacterListViewModel) {
            _viewModel = StateObject(wrappedValue: viewModel)
        }

    
    public var body: some View {
        NavigationView {
                    VStack {
                        // 🔍 Búsqueda y filtros
                        VStack(spacing: 8) {
                            TextField("Buscar por nombre", text: $viewModel.searchText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onSubmit {
                                    viewModel.applyFilters()
                                }

                            HStack {
                                Picker("Estado", selection: $viewModel.selectedStatus) {
                                    ForEach(statuses, id: \.self) {
                                        Text($0.capitalized)
                                    }
                                }

                                Picker("Especie", selection: $viewModel.selectedSpecies) {
                                    ForEach(speciesList, id: \.self) {
                                        Text($0)
                                    }
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        .padding(.horizontal)

                        List {
                            ForEach(viewModel.characters) { character in
                                NavigationLink(destination: CharacterDetailView(character: character)) {
                                    CharacterRow(character: character)
                                        .onAppear {
                                            if character == viewModel.characters.last {
                                                viewModel.fetchCharacters()
                                            }
                                        }
                                }
                            }

                            if viewModel.isLoading {
                                HStack {
                                    Spacer()
                                    ProgressView()
                                    Spacer()
                                }
                            }
                        }
                        .listStyle(.plain)
                        .refreshable {
                            viewModel.refresh()
                        }
                    }
                    .navigationTitle("Personajes")
                }
    }
}

