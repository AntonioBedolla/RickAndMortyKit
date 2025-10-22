//
//  SwiftUIView.swift
//  
//
//  Created by Antonio Bedolla on 22/10/25.
//

import SwiftUI

public struct CharacterListView: View {
    @StateObject private var viewModel: CharacterListViewModel
    
    public init(service: APIServiceProtocol = MockAPIService()) {
        _viewModel = StateObject(wrappedValue: CharacterListViewModel(service: service))
    }
    
    public var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                HStack {
                    AsyncImage(url: URL(string: character.image)) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.headline)
                        Text(character.species)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Rick & Morty")
            .onAppear { viewModel.loadCharacters() }
        }
    }
}

