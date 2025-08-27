//
//  TabState.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 24/08/2025.
//

import Foundation
import ReduxCore

enum Tab {
    case counter, image
}

struct TabState: StateReducer {
    typealias State = TabState
    
    var selectedTab: Tab = .counter
    var counterState: CounterState
    var imageState: ImageState
    
    static let initial = State(
        selectedTab: .counter,
        counterState: CounterState.initial,
        imageState: ImageState.initial
    )

    static func stateReduce(into state: inout TabState, action: any Action) {
        
        switch action {
        case let action as TabActions.SelectedTab:
            state.selectedTab = action.tab
            
        case is CounterActions.StartLoading:
            state.counterState = CounterState.reduce(state.counterState, with: action)
            
        case is CounterActions.LoadingFinished:
            state.counterState = CounterState.reduce(state.counterState, with: action)
            
        case is CounterActions.AddSingleItem:
            state.counterState = CounterState.reduce(state.counterState, with: action)
            
        case is CounterActions.ClearItems:
            state.counterState = CounterState.reduce(state.counterState, with: action)
            
        case is ImageActions.DownloadImage:
            state.imageState = ImageState.reduce(state.imageState, with: action)
            
        case is ImageActions.CompletionImage:
            state.imageState = ImageState.reduce(state.imageState, with: action)
            
        case is ImageActions.ErrorDownloadImage:
            state.imageState = ImageState.reduce(state.imageState, with: action)
            
        default:
            break
        }
    }
}


