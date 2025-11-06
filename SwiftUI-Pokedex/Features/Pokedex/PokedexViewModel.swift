import Foundation

@MainActor
@Observable
class PokedexViewModel {
    private let service: PokemonServiceProtocol

    var pokemons: [Pokemon] = []
    var isLoading = true

    init(service: PokemonServiceProtocol = PokeAPIService()) {
        self.service = service
    }

    func fetchPokemons(number: Int) async {
        do {
            self.isLoading = true

            let basicPokemons = try await service.fetchPokemons(offset: number, limit: 100)

            var detailedPokemons: [Pokemon] = []
            try await withThrowingTaskGroup(of: Pokemon?.self) { group in
                for item in basicPokemons {
                    group.addTask {
                        try? await self.service.fetchPokemonDetails(from: "https://pokeapi.co/api/v2/pokemon/\(item.name)")
                    }
                }

                for try await result in group {
                    if let pokemon = result {
                        detailedPokemons.append(pokemon)
                    }
                }
            }

            self.pokemons = detailedPokemons.sorted { $0.id < $1.id }
            self.isLoading = false

        } catch {
            print("Erreur fetchPokemons: ", error)
            self.isLoading = false
        }
    }
}
