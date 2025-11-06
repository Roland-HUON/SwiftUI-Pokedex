//
//  FriendsView.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//

import SwiftUI

struct FriendsView: View {
    @StateObject private var viewModel = FriendsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.loginBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                List(viewModel.friends) { friend in
                    NavigationLink(destination: ChatView(friend: friend)){
                        HStack(spacing: 12) {
                            AsyncImage(url: URL(string: friend.avatar)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(friend.pseudo ?? "\(friend.firstname) \(friend.lastName)")
                                    .font(.headline)
                                Text(friend.idLogin)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.top, 10)
                        .padding(.vertical, 4)
                    }
                }
                .navigationTitle("Friends")
                .overlay {
                    if viewModel.isLoading {
                        ProgressView("Chargement...")
                    }
                }
                .onAppear {
                    viewModel.loadFriends()
                }
                .background(.clear)
                .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview{
    FriendsView()
}
