//
//  PokemonView.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 05/11/2025.
//

import SwiftUI
import AVFoundation
import DesignSystem

public struct PokemonView: View {
    let pokemon: Pokemon
    @State private var audioPlayer: AVPlayer?
    
    func colorType(forType type: String) -> Color {
        switch type.lowercased() {
        case "normal": return Color.gray
        case "fire": return Color.red
        case "water": return Color.blue
        case "electric": return Color.yellow
        case "grass": return Color.green
        case "ice": return Color.cyan
        case "fighting": return Color.orange
        case "poison": return Color.purple
        case "ground": return Color.brown
        case "flying": return Color.indigo
        case "psychic": return Color.pink
        case "bug": return Color.teal
        case "rock": return Color(.sRGB, red: 168/255, green: 144/255, blue: 122/255, opacity: 1)
        case "ghost": return Color(.sRGB, red: 112/255, green: 88/255, blue: 152/255, opacity: 1)
        case "dragon": return Color(.sRGB, red: 112/255, green: 56/255, blue: 248/255, opacity: 1)
        case "dark": return Color(.sRGB, red: 112/255, green: 88/255, blue: 72/255, opacity: 1)
        case "steel": return Color(.sRGB, red: 184/255, green: 184/255, blue: 208/255, opacity: 1)
        case "fairy": return Color(.sRGB, red: 238/255, green: 153/255, blue: 172/255, opacity: 1)
        default: return Color.gray
        }
    }
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
    
    public var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemon.id).png")) { image in
                    image.resizable()
                         .padding()
                         .scaledToFit()
                         .frame(width: 200, height: 200)
                         .background(
                             LinearGradient(
                                colors: pokemon.types.map { colorType(forType: $0.type.name).opacity(0.8) },
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                             )
                         )
                         .clipShape(Circle())
                         .shadow(radius: 10)
                         .onTapGesture {
                            playPokemonCry()
                         }
                } placeholder: {
                    ProgressView()
                }

                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.black)

                HStack {
                    ForEach(pokemon.types, id: \.slot) { typeEntry in
                        Text(typeEntry.type.name.capitalized)
                            .padding(8)
                            .background(colorType(forType: typeEntry.type.name))
                            .cornerRadius(10)
                            .foregroundStyle(.black)
                    }
                }

                VStack(spacing: 10) {
                    Text("Abilities :")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(.black)
                    
                    HStack {
                        ForEach(pokemon.abilities, id: \.slot) { ability in
                            Text(ability.ability.name.capitalized)
                                .padding(8)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(10)
                                .foregroundStyle(.black)
                        }
                    }
                }
                VStack(spacing: 10) {
                    Text("Stats :")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(.black)
                    
                    HStack {
                        LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                            ForEach(pokemon.stats) { stat in
                                Text("\(stat.stat.name.capitalized) : \(stat.base_stat)")
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                }
                .padding()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .multilineTextAlignment(.center)
        }
    }
    
    private func playPokemonCry() {
        guard let cryURLString = pokemon.cries.latest ?? pokemon.cries.legacy,
            let url = URL(string: cryURLString) else {
                print("⚠️ Aucun cri disponible pour ce Pokémon.")
                return
            }
            
        audioPlayer = AVPlayer(url: url)
        audioPlayer?.play()
        print("Lecture du cri : \(url)")
    }

    func typesMap(for pokemon: Pokemon) -> [String] {
        return pokemon.types.map { $0.type.name }
    }
}

#Preview {
    let samplePokemon = Pokemon(
        id: 1,
        name: "bulbasaur",
        cries: Pokemon.Cries(latest: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/1.ogg", legacy: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/legacy/1.ogg"),
        types: [
            Pokemon.PokemonTypeEntry(
                slot: 1,
                type: Pokemon.PokemonTypeEntry.TypeInfo(name: "grass", url: "")
            ),
            Pokemon.PokemonTypeEntry(
                slot: 2,
                type: Pokemon.PokemonTypeEntry.TypeInfo(name: "poison", url: "")
            )
        ],
        abilities: [
            Pokemon.AbilityEntry(
                ability: Pokemon.AbilityEntry.AbilityInfo(name: "overgrow", url: ""),
                is_hidden: false,
                slot: 1
            ),
            Pokemon.AbilityEntry(
                ability: Pokemon.AbilityEntry.AbilityInfo(name: "chlorophyll", url: ""),
                is_hidden: true,
                slot: 3
            )
        ],
        stats: [
            .init(base_stat: 45, effort: 0, stat: Pokemon.Stat.StatInfo(name: "hp", url: "")),
            .init(base_stat: 49, effort: 0, stat: Pokemon.Stat.StatInfo(name: "attack", url: "")),
            .init(base_stat: 49, effort: 0, stat: Pokemon.Stat.StatInfo(name:"defense", url: "")),
            .init(base_stat: 65, effort: 0, stat: Pokemon.Stat.StatInfo(name:"special-attack", url: "")),
            .init(base_stat: 65, effort: 0, stat: Pokemon.Stat.StatInfo(name:"special-defense", url: "")),
            .init(base_stat: 45, effort: 0, stat: Pokemon.Stat.StatInfo(name:"speed", url: ""))
        ]
    )
    
    PokemonView(pokemon: samplePokemon)
}
