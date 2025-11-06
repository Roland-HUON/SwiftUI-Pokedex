//
//  MessageModel.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let sender: String
    let text: String
    let timestamp: Date
}
