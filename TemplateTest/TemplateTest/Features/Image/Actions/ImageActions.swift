//
//  ImageActions.swift
//  TemplateTest
//
//  Created by Yaroslav Golinskiy on 24/08/2025.
//

import Foundation
import ReduxCore
import UIKit

enum ImageActions {
    struct DownloadImage: Action { }
    struct CompletionImage: Action { let image: UIImage  }
    struct ErrorDownloadImage: Action { let error: Error }
}
