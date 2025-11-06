//
//  PokemonModel.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//

struct Pokemon: Identifiable, Codable {
    let id : Int
    let name: String
    let cries: Cries
    let types: [PokemonTypeEntry]
    let abilities: [AbilityEntry]
    let stats: [Stat]

    struct Cries: Codable {
        let latest: String?
        let legacy: String?
    }

    struct PokemonTypeEntry: Codable {
        let slot: Int
        let type: TypeInfo

        struct TypeInfo: Codable {
            let name: String
            let url: String
        }
    }

    struct AbilityEntry: Codable {
        let ability: AbilityInfo
        let is_hidden: Bool
        let slot: Int

        struct AbilityInfo: Codable {
            let name: String
            let url: String
        }
    }
    
    struct Stat: Codable, Identifiable {
        var id: String { stat.name }
        let base_stat: Int
        let effort: Int
        let stat: StatInfo
        
        struct StatInfo: Codable {
            let name: String
            let url: String
        }
    }
}

struct PokemonListItem: Codable {
    let name: String
    let url: String
}

struct PokemonResponse: Codable {
    let results: [PokemonListItem]
}
