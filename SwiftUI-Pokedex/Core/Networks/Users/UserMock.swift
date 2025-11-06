//
//  UserMock.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//

import Foundation

final class UserMock {
    static let shared = UserMock()
    
    private init() {}
    
    func getFriends() -> [UserModel] {
        return [
            UserModel(
                id: 1,
                pseudo: "Lulu",
                firstname: "Lucie",
                lastName: "Martin",
                avatar: "https://randomuser.me/api/portraits/women/1.jpg",
                idLogin: "lucie01",
                password: "password"
            ),
            UserModel(
                id: 2,
                pseudo: "Tomy",
                firstname: "Thomas",
                lastName: "Durand",
                avatar: "https://randomuser.me/api/portraits/men/2.jpg",
                idLogin: "thomasD",
                password: "123456"
            ),
            UserModel(
                id: 3,
                pseudo: "Juju",
                firstname: "Julien",
                lastName: "Bernard",
                avatar: "https://randomuser.me/api/portraits/men/3.jpg",
                idLogin: "jujuB",
                password: "azerty"
            )
        ]
    }
}
