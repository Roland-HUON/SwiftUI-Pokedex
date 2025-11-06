//
//  UserManager.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//

import Foundation
import Observation

@MainActor
@Observable
final class UserManager {
    var currentUser: UserModel? {
        didSet {
            saveUser()
        }
    }

    private let userKey = "currentUser"

    init() {
        loadUser()
    }

    private func saveUser() {
        guard let user = currentUser else {
            UserDefaults.standard.removeObject(forKey: userKey)
            return
        }

        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
        }
    }

    private func loadUser() {
        guard let data = UserDefaults.standard.data(forKey: userKey),
              let decoded = try? JSONDecoder().decode(UserModel.self, from: data)
        else {
            currentUser = nil
            return
        }
        currentUser = decoded
    }

    func logout() {
        currentUser = nil
    }
}
