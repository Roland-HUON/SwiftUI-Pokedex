//
//  HomeView.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 04/11/2025.
//

import SwiftUI
import DesignSystem

struct HomeView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Image(.background)
            VStack{
                HStack{
                    HStack(spacing: 10){
                        Text("Pseudo")
                            .bold()
                            .foregroundColor(.black)
                        Image(.pokeball)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Spacer()
                    
                }
                .padding()
                HStack(alignment: .top){
                    Text("SwiftUI-Pokedex")
                        .foregroundStyle(.black)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 100.0)
                        .padding(.vertical, 100.0)
                        .background(.white)
                }
                VStack(alignment: .center){
                    HStack (alignment: .center, spacing: 20.0) {
                        BtnHome(
                            destination: ContentView(),
                            text: "Pokedex",
                            image: "Pokeball",
                            backgroundColor: .white
                        )
                        BtnHome(
                            destination: ContentView(),
                            text: "My Team",
                            image: "Pokeball",
                            backgroundColor: .white
                        )
                    }
                    HStack (alignment: .center, spacing: 20.0) {
                        BtnHome(
                            destination: ContentView(),
                            text: "Trainers",
                            image: "Pokeball",
                            backgroundColor: .white
                        )
                        BtnHome(
                            destination: ContentView(),
                            text: "Friends",
                            image: "Pokeball",
                            backgroundColor: .white
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
