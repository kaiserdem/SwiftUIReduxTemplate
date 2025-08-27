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
    
    let tabStore = ObservableStore<TabState>(
       store: Store<TabState>(
           state: TabState.inital,
           reducer: TabState.reduce,
           middlewares: [
               DebugLogMiddleware<TabState>().middleware(),
               APICounterMiddleware().middleware(),
               ImageMiddleware().middleware()
           ]
       )
   )
    
    
    let loginStore = ObservableStore<LoginState>(
        store: Store<LoginState>(
            state: LoginState.inital,
            reducer: LoginState.reduce,
            middlewares: [
                LoginMiddleware().middleware()
            ]
        )
    )
    
    var body: some View {
        Group {
            if let store = store {
                VStack {
                    if store.state.isLoggedIn {
                        
                             
                        
                        TabView()
                            .environment(\.tabStateStore, tabStore)
                        
                    } else {
                        LoginView()
                            .environment(\.loginStateStore, loginStore)
                    }
                }
            }
        }
    }
}
