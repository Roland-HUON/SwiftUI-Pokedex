//
//  UserModel.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//

import SwiftUI

public struct UserModel: Identifiable, Codable {
    public var id: Int
    public var pseudo: String?
    public var firstname : String
    public var lastName : String
    public var avatar : String
    public var idLogin : String
    public var password : String
}
