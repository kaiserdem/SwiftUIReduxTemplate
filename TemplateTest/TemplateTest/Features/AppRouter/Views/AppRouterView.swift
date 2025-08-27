//
//  AppRouterView.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 26/08/2025.
//

import SwiftUI
import ReduxCore

struct AppRouterView: View {
    
    @Environment(\.appRouterStateStore) private var store: ObservableStore<AppRouterState>?
    
    var body: some View {
        if let store = store {
            Group {
                if store.state.isLoggedIn {
                    TabView()
                        .environment(\.appRouterStateStore, store)
                } else {
                    LoginView()
                        .environment(\.appRouterStateStore, store)
                }
            }
        } 
    }
}
