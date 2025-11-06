//
//  MyTeamView.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 05/11/2025.
//
import SwiftUI
import DesignSystem

class MyTeamViewModel: ObservableObject {
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

struct MyTeamView: View {
    @StateObject var pokedexViewModel = PokedexViewModel()
    @StateObject var teamViewModel = MyTeamViewModel()
    
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)
    
    let columnsTeam = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    
    var body: some View {
        ZStack(alignment: .top) {
            Image(.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image(.pokeball)
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Pseudo")
                        .foregroundStyle(.black)
                        .bold()
                }
                .padding(.horizontal, 30)
                VStack(spacing: 20) {
                    if !teamViewModel.team.isEmpty {
                        Text("My Team")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.black)
                        
                        LazyVGrid(columns: columnsTeam, spacing: 20) {
                            ForEach(teamViewModel.team) { pokemon in
                                ZStack(alignment: .topTrailing) {
                                    PokemonCard(
                                        imageURL: pokemonImageURL(pokemonId: pokemon.id),
                                        types: typesMap(for: pokemon)
                                    )
                                    
                                    Button {
                                        teamViewModel.removePokemonFromTeam(pokemon)
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.red)
                                            .background(Circle().fill(Color.white))
                                    }
                                    .offset(x: -6, y: 6)
                                }
                            }
                        }
                        .padding()
                    }
                }
                .padding()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(pokedexViewModel.pokemons.filter { pokemon in !teamViewModel.team.contains(where: { $0.id == pokemon.id })}) { pokemon in
                            PokemonCard(
                                imageURL: pokemonImageURL(pokemonId: pokemon.id),
                                types: typesMap(for: pokemon)
                            )
                            .onTapGesture {
                                teamViewModel.addPokemonToTeam(pokemon)
                            }
                        }
                    }
                    .padding()
                }
                .padding()
                    
            }
            .scrollContentBackground(.hidden)
        }
        .task {
            await pokedexViewModel.fetchPokemons(number: 0)
        }
    }
    
    private func pokemonImageURL(pokemonId: Int) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonId).png"
    }
    
    private func typesMap(for pokemon: Pokemon) -> [String] {
        return pokemon.types.map { $0.type.name }
    }
}

#Preview {
    MyTeamView()
}
