//
//  SwiftUI_PokedexApp.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 04/11/2025.
//

import SwiftUI

@main
struct SwiftUI_PokedexApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                LoginView()
            }
            .background(Color.clear)
            .scrollContentBackground(.hidden)
        }
    }
}
