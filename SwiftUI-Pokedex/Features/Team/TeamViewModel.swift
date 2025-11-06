//
//  TeamViewModel.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//

import SwiftUI

class TeamViewModel: ObservableObject {
    @Published var team: [Pokemon] = []
    
    func addPokemonToTeam(_ pokemon: Pokemon) {
        if !team.contains(where: { $0.id == pokemon.id }) && team.count < 6 {
            team.append(pokemon)
        }
    }
    
    func removePokemonFromTeam(_ pokemon: Pokemon) {
        team.removeAll { $0.id == pokemon.id }
    }
}
