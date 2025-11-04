//
//  PokedexView.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 04/11/2025.
//
import SwiftUI

struct Pokemon: Codable, Identifiable {
    var id = UUID()
    let name: String
    let url: String
}

@Observable
class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon]?
    @Published var isLoading: Bool = true
    
    func fetchPokemons(number: Int) async {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=\(number)&limit=20") else { return }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
            
            let decoded = try JSONDecoder().decode([Pokemon].self, from: data)
            self.pokemons = decoded
            self.isLoading = false
        } catch {
            print("Erreur :", error)
            self.isLoading = false
        }
    }
}

struct ContentView: View {
    @State var pokemonViewModel = PokemonViewModel()
    var body: some View {
        ZStack(){
            VStack {
                
                //Image(systemName: "globe")
                //   .imageScale(.large)
                //   .foregroundStyle(.tint)
                //Text("Count \(pokemonViewModel.counter)")
                //   .foregroundColor(.red)
                //    .bold()
                //    .background(.yellow)
                //    .multilineTextAlignment(.center)
                List{
                    ForEach(pokemonViewModel.pokemons ?? []){ pokemons in
                        HStack{
                            AsyncImage(url: URL(string: "\(pokemons.url)"))
                            Text("\(pokemons.name)")
                        }
                    }
                }
                //HStack{
                //    Button("Prev", action: Prev)
                //    Button("Next", action: Next)
                //}
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .task(){
            await pokemonViewModel.fetchPokemons(number: 0)
        }
    }
}

#Preview {
    ContentView()
}
