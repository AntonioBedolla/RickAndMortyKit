//
//  File.swift
//  
//
//  Created by Antonio Bedolla on 23/10/25.
//

import XCTest

@testable import RickAndMortyKit

public final class CharacterListViewModelTests: XCTestCase {
    
    func testFetchCharactersReturnsMockedData() {
        // Arrange
        let mockService = MockAPIService()
        let viewModel = CharacterListViewModel(apiService: mockService)

        let expectation = XCTestExpectation(description: "Fetch mocked characters")

        // Act
        viewModel.fetchCharacters()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Assert
            XCTAssertEqual(viewModel.characters.count, 1)
            XCTAssertEqual(viewModel.characters.first?.name, "Rick Sanchez")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
}
