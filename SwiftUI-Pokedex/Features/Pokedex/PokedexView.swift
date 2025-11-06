//
//  PokedexView.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 04/11/2025.
//
import SwiftUI
import DesignSystem

struct PokedexView: View {
    @State var pokedexViewModel = PokedexViewModel()
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)
    
    var body: some View {
        ZStack(alignment: .top){
            Image(.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(alignment: .leading){
                HStack(alignment: .center){
                    Image(.pokeball)
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Username")
                        .foregroundStyle(.black)
                        .bold()
                        
                }
                .padding(.horizontal, 30)
                VStack{
                    ScrollView{
                        Text("Pokedex")
                            .bold()
                            .font(.largeTitle)
                            .shadow(radius: 4)
                            .padding(.top, 10)
                            .foregroundStyle(.black)
                        LazyVGrid(columns: columns, spacing: 20){
                            ForEach(pokedexViewModel.pokemons) { pokemon in
                                NavigationLink(destination: PokemonView(pokemon: pokemon)){
                                    PokemonCard(imageURL: pokemonImageURL(pokemonId: pokemon.id), types: typesMap(for: pokemon))
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                    .padding()
                    .scrollContentBackground(.hidden)
                    .cornerRadius(12)
                    .shadow(
                        color: .black.opacity(0.4),
                        radius: 10,
                        x: 10,
                        y: 10
                    )
                }
            }
        }
        .task() {
            await pokedexViewModel.fetchPokemons(number: 0)
        }
    }
    
    private func pokemonImageURL(pokemonId: Int) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonId).png"
    }
    func typesMap(for pokemon: Pokemon) -> [String] {
        return pokemon.types.map { $0.type.name }
    }
}

#Preview {
    PokedexView()
}
