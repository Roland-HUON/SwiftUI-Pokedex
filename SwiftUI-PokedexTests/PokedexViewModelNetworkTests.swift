//
//  PokedexViewModelNetworkTests.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//

import XCTest
@testable import SwiftUI_Pokedex

@MainActor
final class PokedexViewModelNetworkTests: XCTestCase {

    func testFetchPokemonsFromAPI() async throws {
        let viewModel = PokedexViewModel()

        await viewModel.fetchPokemons(number: 0)

        XCTAssertFalse(viewModel.isLoading, "Le loading doit être désactivé après fetch")
        XCTAssertFalse(viewModel.pokemons.isEmpty, "La liste de pokémons ne doit pas être vide")
        XCTAssertNotNil(viewModel.pokemons.first?.id, "Le premier Pokémon doit avoir un id")
        XCTAssertNotNil(viewModel.pokemons.first?.name, "Le premier Pokémon doit avoir un nom")
    }
}
