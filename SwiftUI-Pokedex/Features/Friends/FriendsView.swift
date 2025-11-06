//
//  FriendsView.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//

import SwiftUI

struct FriendsView: View {
    @State private var viewModel = FriendsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.loginBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack{
                    Text("Friends")
                        .font(.title)
                        .foregroundStyle(.white)
                        .bold()
                        .padding(.top)
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
                            .padding(.vertical, 4)
                        }
                    }
                    .overlay {
                        if viewModel.isLoading {
                            ProgressView("Loading...")
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
}

#Preview{
    FriendsView()
}
