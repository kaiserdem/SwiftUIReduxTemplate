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
    
    var application: ApplicationState
    var selectedTab: Tab = .image
    var counterState: CounterState.State = .initial
    var imageState: ImageState.State = .inital
    
    static let inital = State(application: ApplicationState.initial,
                              selectedTab: .image,
                              counterState: CounterState.initial,
                              imageState: ImageState.inital)

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
            
        case is ApplicationLifecycleActions.DidBecomeActive:
            state.application = .active
            
        case is ApplicationLifecycleActions.DidEnterBackground:
            state.application = .background
            
        case is ApplicationLifecycleActions.WillResignActive:
            state.application = .inactive
            
        default:
            print("Невідомий action: \(type(of: action))")
            break
        }
    }
}


