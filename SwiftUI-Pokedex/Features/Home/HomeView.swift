//
//  HomeView.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 04/11/2025.
//

import SwiftUI
import DesignSystem

struct HomeView: View {
    @Environment(UserManager.self) var userManager
    let columns = [
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            Image(.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                if let user = userManager.currentUser {
                    Header(username: user.pseudo ?? user.firstname)
                }
                
                VStack(alignment: .center) {
                    Text("SwiftUI-Pokedex")
                        .bold()
                        .font(.largeTitle)
                        .shadow(radius: 4)
                        .foregroundStyle(.black)
                    LazyVGrid(columns: columns, spacing: 20) {
                        BtnHome(
                            destination: PokedexView(),
                            text: "Pokedex",
                            image: "Pokeball",
                            backgroundColor: .purple,
                            color: .black
                        )
                        BtnHome(
                            destination: TeamView(),
                            text: "My Team",
                            image: "Pokeball",
                            backgroundColor: .white,
                            color: .black
                        )
                        BtnHome(
                            destination: FriendsView(),
                            text: "Friends",
                            image: "Pokeball",
                            backgroundColor: .white,
                            color: .black
                        )
                    }
                    .frame(maxHeight: .infinity)
                    .shadow(
                        color: .black.opacity(0.4),
                        radius: 10,
                        x: 10,
                        y: 10
                    )
                    .padding(.horizontal)
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeView()
        .environment(UserManager())
}
