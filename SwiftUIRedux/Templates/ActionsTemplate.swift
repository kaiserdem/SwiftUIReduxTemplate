//
//  Actions.swift
//  YourProjectName
//
//  Created by You on Date.
//

import Foundation
import ReduxCore

/// Namespace for all application actions
/// Organized by feature/middleware for better structure
/// Namespace для всіх дій додатку
/// Організовано за функціоналом/middleware для кращої структури
enum Actions {
    
    // MARK: - Application Lifecycle Actions (DO NOT MODIFY)
    // MARK: - Дії життєвого циклу додатку (НЕ ЗМІНЮВАТИ)
    
    /// Actions triggered by app lifecycle events (from ScenePhase)
    /// Дії викликані подіями життєвого циклу додатку (з ScenePhase)
    enum AppLifecycle {
        
        /// App became active (foreground and ready)
        /// Додаток став активним (на передньому плані і готовий)
        struct DidBecomeActive: Action {}
        
        /// App will resign active (before background/inactive)
        /// Додаток втратить активність (перед фоном/неактивністю)
        struct WillResignActive: Action {}
        
        /// App entered background
        /// Додаток перейшов у фоновий режим
        struct DidEnterBackground: Action {}
        
        /// App will enter foreground
        /// Додаток переходить на передній план
        struct WillEnterForeground: Action {}
        
        /// App finished launching
        /// Додаток завершив запуск
        struct DidFinishLaunch: Action {}
    }
    
    // MARK: - TODO: Add your custom actions here
    // MARK: - TODO: Додайте ваші кастомні дії тут
    
    /// Example: UI Actions for main screen
    /// Приклад: UI дії для головного екрану
    enum MainScreen {
        
        /// Example: User tapped a button
        /// Приклад: Користувач натиснув кнопку
        struct ButtonTapped: Action {
            let buttonType: String
        }
        
        // TODO: Add more UI actions
        // TODO: Додайте більше UI дій
    }
    
    /// Example: Actions for API calls
    /// Приклад: Дії для API викликів
    enum API {
        
        /// Start loading data
        /// Почати завантаження даних
        struct StartLoading: Action {}
        
        /// Data loaded successfully
        /// Дані завантажені успішно
        struct LoadSuccess: Action {
            let data: [String] // Replace with your data type
        }
        
        /// Loading failed
        /// Завантаження не вдалося
        struct LoadFailure: Action {
            let error: Error
        }
        
        // TODO: Add more API actions
        // TODO: Додайте більше API дій
    }
}
