//
//  FriendsViewModel.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//

import Foundation

@MainActor
final class FriendsViewModel: ObservableObject {
    @Published var friends: [UserModel] = []
    @Published var isLoading = false
    
    private let mock = UserMock.shared
    
    func loadFriends() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.friends = self.mock.getFriends()
            self.isLoading = false
        }
    }
}
