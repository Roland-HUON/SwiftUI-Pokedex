//
//  FriendsViewModel.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//

import Foundation

@MainActor
@Observable
final class FriendsViewModel {
    var friends: [UserModel] = []
    var isLoading = false
    
    private let mock = UserMock.shared
    
    func loadFriends() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.friends = self.mock.getUsers()
            self.isLoading = false
        }
    }
}
