//
//  ChatViewModel.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 06/11/2025.
//
import Foundation
import SwiftUI

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var userInput: String = ""
    
    let friend: UserModel
    
    init(friend: UserModel) {
        self.friend = friend
    }
    
    func sendMessage() {
        let text = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        
        let myMessage = Message(sender: "me", text: text, timestamp: Date())
        messages.append(myMessage)
        userInput = ""
        
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            let response = getAutoResponse(for: text.lowercased())
            if let response {
                let reply = Message(sender: friend.pseudo ?? friend.firstname, text: response, timestamp: Date())
                messages.append(reply)
            }
        }
    }
    
    private func getAutoResponse(for input: String) -> String? {
        switch input {
        case "bonjour", "salut", "yo":
            return "Bonjour 👋"
        case "ça va", "ca va", "tu vas bien":
            return "Oui, et toi ? 😊"
        case "au revoir", "bye":
            return "À bientôt ! 👋"
        case "pikachu":
            return "Pika Pika ⚡️"
        default:
            return nil
        }
    }
}
