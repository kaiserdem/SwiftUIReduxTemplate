//
//  ContentView.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//

import SwiftUI
import ReduxCore

struct CounterView: View {
    @Environment(\.appRouterStateStore) private var store: ObservableStore<AppRouterState>?
    
    var body: some View {
        VStack(spacing: 20) {
            if let store = store {
                
                if store.state.tabbarState.counterState.isLoading {
                    ProgressView()
                } else {
                    Text("App is: \(store.state.application == .active ? "Active" : "Inactive")")
                }
                
                Text("Items count: \(store.state.tabbarState.counterState.items.count)")
                
                VStack {
                    Button("Add Item") {
                        store.dispatch(action: CounterActions.AddSingleItem())
                    }
                    .modifier(CounterButtonStyle())
                    
                    Button("Load More") {
                        store.dispatch(action: CounterActions.StartLoading())
                    }
                    .modifier(CounterButtonStyle())
                    
                    Button("Clear All") {
                        store.dispatch(action: CounterActions.ClearItems())
                    }
                    .modifier(CounterButtonStyle())
                }
                
                ScrollView {
                    ForEach(store.state.tabbarState.counterState.items, id: \.self) { item in
                        Text(item)
                            .padding(.horizontal)
                    }
                }
            } 
        }
        .padding()
    }
}

struct CounterButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .border(.gray)
    }
}
