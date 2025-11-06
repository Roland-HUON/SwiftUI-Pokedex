//
//  loginView.swift
//  SwiftUI-Pokedex
//
//  Created by HUON Roland on 05/11/2025.
//

import SwiftUI
import DesignSystem

struct LoginView: View {
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var isLoggedIn: Bool = false
    @State private var remainingTries = 3

    var isSignInButtonDisabled: Bool {
        [id, password].contains(where: \.isEmpty)
    }

    var body: some View {
        ZStack {
            Image(.loginBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            if isLoggedIn {
                HomeView()
            } else {
                VStack(spacing: 20) {
                    Text("SwiftUI-Pokedex")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)

                        TextField("ID", text: $id, prompt: Text("Enter your ID here")
                            .foregroundColor(.blue))
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 2)
                        )
                        .padding(.horizontal)

                        HStack {
                            Group {
                                if showPassword {
                                    TextField("Password", text: $password, prompt: Text("Password").foregroundColor(.red))
                                } else {
                                    SecureField("Password", text: $password, prompt: Text("Password").foregroundColor(.red))
                                }
                            }
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10
                                                )
                            .stroke(.red, lineWidth: 2)
                                    )

                            Button {
                                showPassword.toggle()
                            } label: {
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.horizontal)

                        Button {
                            if checkLogin() {
                                isLoggedIn = true
                            }
                        } label: {
                            Text("Sign In")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(
                            isSignInButtonDisabled ?
                            LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing) :
                                    LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .cornerRadius(20)
                            .disabled(isSignInButtonDisabled)
                            .padding(.horizontal, 30)
                    }
                    .padding(50)
                    .background(
                        Color.white.opacity(0.7)
                            .blur(radius: 10)
                            .cornerRadius(20)
                    )
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .frame(maxWidth: 400)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .multilineTextAlignment(.center)
            }
        }
    }

    private func checkLogin() -> Bool {
        if id == "pikapika" && password == "pikachuchu" {
            print("Login successful!")
            return true
        } else {
            remainingTries -= 1
            id = ""
            password = ""
            print("Login Failed. Try Again (\(remainingTries) left)")
            return false
        }
    }
}

#Preview {
    LoginView()
}
