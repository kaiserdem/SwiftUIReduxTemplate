//
//  ContentView.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 23/08/2025.
//

import SwiftUI
import ReduxCore

struct CounterView: View {
    @Environment(\.appStateStore) private var store: ObservableStore<AppState>?
    
    var body: some View {
           VStack(spacing: 20) {
               if let store = store {
                   
                   if store.state.isLoading {
                       ProgressView()
                   } else {
                       Text("App is: \(store.state.application == .active ? "Active" : "Inactive")")
                       
                   }
                   Text("Items count: \(store.state.items.count)")
                   
                   // Кнопки
                   VStack {
                       Button("Add Item") {
                           let newItem = "Item \(store.state.items.count + 1)"
                           store.dispatch(action: Actions.AddSingleItem(item: newItem))
                       }
                       .modifier(CounterButtonStyle())
                       
                       Button("Load More") {
                           store.dispatch(action: Actions.StartLoading())
                       }
                       .modifier(CounterButtonStyle())
                       
                       Button("Clear All") {
                           store.dispatch(action: Actions.ClearItems())
                       }
                       .modifier(CounterButtonStyle())
                   }
                   
                   // Список елементів
                   ScrollView {
                       ForEach(store.state.items, id: \.self) { item in
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
