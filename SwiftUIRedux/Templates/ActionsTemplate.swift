//
//  Actions.swift
//  YourProjectName
//
//  Created by You on Date.
//

import Foundation
import ReduxCore

/// Namespace for all application actions
/// Простий та зрозумілий підхід без зайвої складності
/// Namespace для всіх дій додатку
/// Простий та зрозумілий підхід без зайвої складності
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
    }
    
    // MARK: - TODO: Add your custom actions here
    // MARK: - TODO: Додайте ваші кастомні дії тут
    
    /// Example: Simple actions for main functionality
    /// Приклад: Прості дії для основного функціоналу
    
    /// Start loading data
    /// Почати завантаження даних
    struct StartLoading: Action {}
    
    /// Data loaded successfully
    /// Дані завантажені успішно
    struct LoadingFinished: Action { 
        let items: [String] // Replace with your data type
    }
    
    /// Add single item
    /// Додати один елемент
    struct AddSingleItem: Action { 
        let item: String // Replace with your data type
    }
    
    /// Clear all items
    /// Очистити всі елементи
    struct ClearItems: Action {}
    
    // TODO: Add more actions as needed
    // TODO: Додайте більше дій за потреби
}
