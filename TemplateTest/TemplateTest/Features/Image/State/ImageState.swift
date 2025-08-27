//
//  ImageState.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 24/08/2025.
//

import Foundation
import ReduxCore
import UIKit

struct ImageState: StateReducer {
    typealias State = ImageState
    
    var images: [UIImage] = []
    var isLoading: Bool = false
    
    static let initial = ImageState()
    
    static func stateReduce(into state: inout ImageState, action: any Action) {
        switch action {
        case is ImageActions.DownloadImage:
            state.isLoading = true
            
        case let action as ImageActions.CompletionImage:
            state.isLoading = false
            state.images.append(action.image)
            
        case let action as ImageActions.ErrorDownloadImage:
            state.isLoading = false
            print("Image download error: \(action.error.localizedDescription)")
            
        default:
            break
        }
    }
}
