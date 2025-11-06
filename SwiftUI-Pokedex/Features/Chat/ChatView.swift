//
//  ChatView.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//
import SwiftUI

struct ChatView: View {
    @State private var viewModel: ChatViewModel
    
    init(friend: UserModel) {
        _viewModel = State(wrappedValue: ChatViewModel(friend: friend))
    }
    
    var body: some View {
        ZStack{
            Image(.loginBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                AsyncImage(url: URL(string: viewModel.friend.avatar)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                Text(viewModel.friend.pseudo ?? "Inconnu")
                ScrollView {
                    ScrollViewReader { proxy in
                        LazyVStack(alignment: .leading, spacing: 8) {
                            ForEach(viewModel.messages) { message in
                                HStack {
                                    if message.sender == "me" {
                                        Spacer()
                                        Text(message.text)
                                            .padding(10)
                                            .background(.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    } else {
                                        HStack(alignment: .center, spacing: 8) {
                                            AsyncImage(url: URL(string: viewModel.friend.avatar)) { image in
                                                image.resizable()
                                            } placeholder: {
                                                Color.gray
                                            }
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())
                                            
                                            Text(message.text)
                                                .padding(10)
                                                .background(Color.gray.opacity(0.85))
                                                .cornerRadius(10)
                                        }
                                        Spacer()
                                    }
                                }
                                .id(message.id)
                            }
                        }
                        .padding()
                        .onChange(of: viewModel.messages.count) {
                            withAnimation {
                                proxy.scrollTo(viewModel.messages.last?.id)
                            }
                        }
                    }
                }
                
                HStack {
                    TextField("Write a message...", text: $viewModel.userInput)
                        .padding(10)
                        .background(.white)
                        .cornerRadius(14)
                    
                    Button(action: viewModel.sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                    }
                    .disabled(viewModel.userInput.isEmpty)
                }
                .padding()
            }
            .navigationTitle(viewModel.friend.pseudo ?? viewModel.friend.firstname)
            .padding()
        }
    }
}

#Preview {
    let sampleFriend = UserModel(
        id: 1,
        pseudo: "Iris",
        firstname: "Iris",
        lastName: "Unknown",
        avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3l3Ss4ciBkVzmFw7TUZoUGlsL8vZQzIRU5A&s",
        idLogin: "IrisH",
        password: "password"
    )
    ChatView(friend: sampleFriend)
}
