//
//  PokedexViewModel.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//
import SwiftUI

@MainActor
class PokedexViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading = true

    func fetchPokemons(number: Int) async {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=\(number)&limit=100") else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(PokemonResponse.self, from: data)

            let pokemonsDetails: [Pokemon?] = try await withThrowingTaskGroup(of: Pokemon?.self) { group in
                for item in decoded.results {
                    group.addTask {
                        await self.fetchPokemonDetails(from: "https://pokeapi.co/api/v2/pokemon/\(item.name)")
                    }
                }

                var results: [Pokemon?] = []
                for try await result in group {
                    results.append(result)
                }
                return results
            }

            self.pokemons = pokemonsDetails
                                .compactMap { $0 }
                                .sorted { $0.id < $1.id }
            self.isLoading = false

        } catch {
            print("Erreur : ", error)
            self.isLoading = false
        }
    }

    private func fetchPokemonDetails(from urlString: String) async -> Pokemon? {
        guard let url = URL(string: urlString) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(Pokemon.self, from: data)
            return decoded
        } catch {
            print("Erreur Pokémon :", error)
            return nil
        }
    }
}
