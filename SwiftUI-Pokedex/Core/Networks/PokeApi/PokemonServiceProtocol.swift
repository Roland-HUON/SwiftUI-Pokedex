//
//  PokemonServiceProtocol.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//
import Foundation

protocol PokemonServiceProtocol {
    func fetchPokemons(offset: Int, limit: Int) async throws -> [Pokemon]
    func fetchPokemonDetails(from urlString: String) async throws -> Pokemon
}
