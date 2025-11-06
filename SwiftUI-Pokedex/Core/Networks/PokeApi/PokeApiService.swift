//
//  PokeApiService.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//

import Foundation

struct PokeAPIService: PokemonServiceProtocol {
    func fetchPokemons(offset: Int, limit: Int) async throws -> [Pokemon] {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=\(limit)") else {
            return []
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(PokemonResponse.self, from: data)
        var results: [Pokemon] = []
        for item in decoded.results {
            if let pokemon = try? await fetchPokemonDetails(from: "https://pokeapi.co/api/v2/pokemon/\(item.name)") {
                results.append(pokemon)
            }
        }
        return results.sorted { $0.id < $1.id }
    }

    func fetchPokemonDetails(from urlString: String) async throws -> Pokemon {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(Pokemon.self, from: data)
        return decoded
    }
}
