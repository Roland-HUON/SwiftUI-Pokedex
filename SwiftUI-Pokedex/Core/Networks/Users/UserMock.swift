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
    
    func getUsers() -> [UserModel] {
        return [
            UserModel(
                id: 1,
                pseudo: "Iris",
                firstname: "Iris",
                lastName: "Unknown",
                avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3l3Ss4ciBkVzmFw7TUZoUGlsL8vZQzIRU5A&s",
                idLogin: "IrisH",
                password: "password"
            ),
            UserModel(
                id: 2,
                pseudo: "Serena",
                firstname: "Serena",
                lastName: "Unknown",
                avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4MUJSdbbzwUHnh62-JLcgtQk9fbs3PloNIg&s",
                idLogin: "Serena2000",
                password: "123456"
            ),
            UserModel(
                id: 3,
                pseudo: "Cynthia",
                firstname: "Cynthia",
                lastName: "Unknown",
                avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe3NDfSHhg_bE8dvDES34ZxEYJSQ_XlU8iRA&s",
                idLogin: "Cynthia123",
                password: "azerty"
            ),
            UserModel(
                id: 4,
                pseudo: "Pikapika",
                firstname: "Roland",
                lastName: "HUON",
                avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEotLJYD-lr06mEXAJr4S4B8GwWX_Ix_ZjaQ&s",
                idLogin: "pikapika",
                password: "pikachuchu"
            ),
            UserModel(
                id: 5,
                pseudo: "Pierre",
                firstname: "Pierre",
                lastName: "Unknown",
                avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUdiS8DrsqwB-cKiqfcfUHIKu9YVCuzpC4O7LfRDHMO4IJIfHuVmN4iMJvjSpgoe263cE&usqp=CAU",
                idLogin: "Pierre36",
                password: "pierre"
            ),
        ]
    }
    
    static func validate(id: String, password: String) -> UserModel? {
        return shared.getUsers().first { $0.idLogin == id && $0.password == password }
    }
    
}
