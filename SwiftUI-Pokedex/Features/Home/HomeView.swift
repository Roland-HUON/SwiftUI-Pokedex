//
//  HomeView.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 04/11/2025.
//

import SwiftUI
import DesignSystem

struct HomeView: View {
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
                HStack(alignment: .center) {
                    Image(.pokeball)
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Username")
                        .foregroundStyle(.black)
                        .bold()
                }
                .padding(.horizontal)
                
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
                }
                .frame(maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeView()
}

