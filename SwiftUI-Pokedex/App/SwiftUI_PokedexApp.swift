//
//  SwiftUI_PokedexApp.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 04/11/2025.
//

import SwiftUI

@main
struct SwiftUI_PokedexApp: App {
    @State private var userManager = UserManager()
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                LoginView()
                    .environment(userManager)
            }
            .background(Color.clear)
            .scrollContentBackground(.hidden)
        }
    }
}
