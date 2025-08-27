//
//  LoginView.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 25/08/2025.
//

import SwiftUI
import ReduxCore

struct LoginView: View {
    @Environment(\.appRouterStateStore) private var store: ObservableStore<AppRouterState>?
    
    var body: some View {
        if let store = store {
            VStack(spacing: 20) {
                Text("Login Screen")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Text("Please enter your email to continue")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
              
                TextField("Email", text: Binding(
                    get: { store.state.loginState.email },
                    set: { newEmail in
                        store.dispatch(action: LoginActions.EmailChanged(email: newEmail))
                    }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                
                if store.state.loginState.isLoading {
                    ProgressView()
                        .padding()
                }
                
                Button("Login") {
                    store.dispatch(action: LoginActions.SetLogin())
                }
                .buttonStyle(.borderedProminent)
                .disabled(!store.state.loginState.isValidEmail || store.state.loginState.email.isEmpty)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        } else {
            Text("❌ Store не знайдено!")
        }
    }
}
