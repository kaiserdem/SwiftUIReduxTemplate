//
//  LoginView.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 25/08/2025.
//

import SwiftUI
import ReduxCore

struct LoginView: View {
    @Environment(\.loginStateStore) private var store: ObservableStore<LoginState>?
    
    var body: some View {
        if let store = store {
            
            ZStack {
                
                VStack {
                    Text("Login screen")
                        .font(.largeTitle)
                        .bold()
                    
                    Text(!store.state.isLoggedIn ? "Need enter" : "Enter success")
                        .font(.title)
                        .padding()
                        .foregroundColor(store.state.isLoggedIn ? .green : .blue)
                    
                    if store.state.isLoading {
                        ProgressView()
                    }
                    
                       
                    Spacer()
                }
                
                VStack {
                    TextField("Email", text: Binding(
                        get: {store.state.email},
                        set: {store.dispatch(action: LoginActions.EmailChaged(email: $0))}))
                    .padding()
                    .border(store.state.isValidEmail ? .blue : .gray)
                    
                    
                    Button("Login") {
                        store.dispatch(action: LoginActions.SetLogin())
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .disabled(!store.state.isValidEmail)
                    .border(store.state.isValidEmail ? .green : .red)
                }
                .padding()
            }
        }
    }
}
