# SwiftUI Redux Template

Готова Redux архітектура для SwiftUI проектів з українськими коментарями.

## 📁 Структура

```
    SwiftUIRedux/
├── Store/
│ └── StoreProvider.swift # ✅ ГОТОВИЙ: ObservableStore для SwiftUI
├── Commands/
│ └── CommandWith.swift # ✅ ГОТОВИЙ: Command pattern
├── Lifecycle/
│ └── ApplicationState.swift # ✅ ГОТОВИЙ: Життєвий цикл додатку
├── Debugging/
│ └── DebugLogMiddleware.swift # ✅ ГОТОВИЙ: Debug middleware
└── Templates/ # 📝 ШАБЛОНИ ДЛЯ КОПІЮВАННЯ:
├── ActionsTemplate.swift # → скопіюйте як Actions.swift
├── StateTemplate.swift # → скопіюйте як AppState.swift
├── MiddlewareTemplate.swift # → скопіюйте як YourMiddleware.swift
└── AppTemplate.swift # → використайте для оновлення App.swift

```

### 🔍 Пояснення структури:

**✅ Готові компоненти** - використовуйте як є, імпортуйте в свій код  
**📝 Templates** - це стартові шаблони для ВАШОЇ бізнес-логіки

## 🚀 Як використовувати в новому проекті

### Крок 1: Налаштування залежностей
1. Створіть новий SwiftUI проект
2. Додайте ReduxCore через SPM:
   ```
   https://github.com/betterme-dev/ReduxCore
   ```

### Крок 2: Додавання файлів до проекту
1. **Скопіюйте папку `SwiftUIRedux/`** на диск поруч з вашим `.xcodeproj` файлом
2. **В Xcode**: File → Add Files to "[ProjectName]"
3. **Виберіть папку `SwiftUIRedux/`**
4. **Важливо**: Оберіть **"Create folder references"** (не "Create groups")
5. **Переконайтеся** що target вашого проекту обраний
6. Натисніть **"Add"**

💡 **Результат**: У Project Navigator з'явиться синя папка `SwiftUIRedux/`

#### Альтернатива: Перетягування
⚠️ **Увага**: При перетягуванні папки з Finder в Xcode **обов'язково** оберіть **"Create folder references"** в діалозі, інакше папка буде сіра замість синьої!

### ⚠️ ВАЖЛИВО: НЕ додавайте Templates до target!

**Якщо у вас є папка `Templates/`** - **НЕ ДОДАВАЙТЕ** її до target проекту! Це призведе до помилок компіляції.

**Правильно:**
- ✅ Додати тільки папки: `Store/`, `Commands/`, `Lifecycle/`, `Debugging/`
- ❌ НЕ додавати: `Templates/` (якщо вона є)

**Якщо випадково додали Templates:**
1. Виберіть папку `Templates/` в Project Navigator
2. Правий клік → Delete → Remove references

### Крок 3: Створення вашої бізнес-логіки
Тепер створіть файли для ВАШОГО проекту, використовуючи шаблони:

1. **Створіть `Actions.swift`** - скопіюйте код з `Templates/ActionsTemplate.swift`
2. **Створіть `AppState.swift`** - скопіюйте код з `Templates/StateTemplate.swift`  
3. **Створіть ваші Middleware** - скопіюйте код з `Templates/MiddlewareTemplate.swift`
4. **Оновіть `App.swift`** - використайте код з `Templates/AppTemplate.swift`

💡 **Чому копіювати?** Templates - це стартова точка для ВАШОЇ специфічної логіки. Готові компоненти з папок `Store/`, `Commands/`, `Lifecycle/`, `Debugging/` використовуйте як є!


### Крок 4: Обов'язкові файли для роботи

#### 4.1 Створіть Environment Key
**Новий файл: `AppStateStoreKey.swift`**
```swift
import SwiftUI

// Environment Key для вашого конкретного AppState
struct AppStateStoreKey: EnvironmentKey {
    static var defaultValue: ObservableStore<AppState>? = nil
}

extension EnvironmentValues {
    var appStateStore: ObservableStore<AppState>? {
        get { self[AppStateStoreKey.self] }
        set { self[AppStateStoreKey.self] = newValue }
    }
}
```

#### 4.2 Створіть Actions
**Новий файл: `Actions.swift`**
```swift
import Foundation
import ReduxCore

enum Actions {
    // Приклад дій
    struct StartLoading: Action {}
    struct LoadingFinished: Action { let items: [String] }
    struct ShowError: Action { let message: String }
}
```

#### 4.3 Оновіть App.swift
**Замініть приклад на робочий код:**
```swift
import SwiftUI
import ReduxCore

@main
struct YourApp: App {
    private let store = ObservableStore<AppState>(
        store: Store<AppState>(
            state: AppState.initial,
            reducer: reduce,
            middlewares: [
                DebugLogMiddleware<AppState>().middleware()
            ]
        )
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.appStateStore, store)  // ✅ ВИПРАВЛЕНО
        }
        .onChange(of: scenePhase) { _, newPhase in
            switch newPhase {
            case .active:
                store.dispatch(action: ApplicationLifecycleActions.DidBecomeActive())
            case .inactive:
                store.dispatch(action: ApplicationLifecycleActions.WillResignActive())
            case .background:
                store.dispatch(action: ApplicationLifecycleActions.DidEnterBackground())
            @unknown default:
                break
            }
        }
    }
    
    @Environment(\.scenePhase) private var scenePhase
}
```

#### 4.4 Оновіть ContentView.swift
```swift
struct ContentView: View {
    @Environment(\.appStateStore) private var store: ObservableStore<AppState>?  // ✅ ВИПРАВЛЕНО
    
    var body: some View {
        VStack {
            if let store = store {
                Text("App is: \(store.state.application == .active ? "Active" : "Inactive")")
                Text("Items count: \(store.state.items.count)")
                
                Button("Start Loading") {
                    store.dispatch(action: Actions.StartLoading())  // ✅ РОБОЧИЙ ПРИКЛАД
                }
                
                if store.state.isLoading {
                    ProgressView("Loading...")
                }
            }
        }
    }
}
```

## 💡 Приклад використання (оновлений API)


### App.swift
```swift
import SwiftUI
import ReduxCore

@main
struct YourApp: App {
    private let store = ObservableStore<AppState>(
        store: Store<AppState>(
            state: AppState.initial,
            reducer: reduce,
            middlewares: [
                DebugLogMiddleware<AppState>().middleware()
            ]
        )
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.appStateStore, store)  // ✅ ПРАЦЮЄ
        }
        .onChange(of: scenePhase) { _, newPhase in
            switch newPhase {
            case .active:
                store.dispatch(action: ApplicationLifecycleActions.DidBecomeActive())
            case .inactive:
                store.dispatch(action: ApplicationLifecycleActions.WillResignActive())
            case .background:
                store.dispatch(action: ApplicationLifecycleActions.DidEnterBackground())
            @unknown default:
                break
            }
        }
    }
    
    @Environment(\.scenePhase) private var scenePhase
}
```

### ContentView.swift
```swift
struct ContentView: View {
    @Environment(\.appStateStore) private var store: ObservableStore<AppState>?  // ✅ ПРАЦЮЄ
    
    var body: some View {
        VStack(spacing: 20) {
            if let store = store {
                Text("App is: \(store.state.application == .active ? "Active" : "Inactive")")
                Text("Items count: \(store.state.items.count)")
                
                Button("Start Loading") {
                    store.dispatch(action: Actions.StartLoading())  // ✅ ІСНУЄ
                }
                
                if store.state.isLoading {
                    ProgressView("Loading...")
                }
                
                ForEach(store.state.items, id: \.self) { item in
                    Text(item)
                }
            }
        }
        .padding()
    }
}
```

### Actions.swift (обов'язковий файл)
```swift
import Foundation
import ReduxCore

enum Actions {
    struct StartLoading: Action {}
    struct LoadingFinished: Action { let items: [String] }
    struct ClearItems: Action {}
}
```

## ✨ Переваги

- **SwiftUI нативність**: `@Observable` та `Environment`
- **Життєвий цикл**: Автоматична обробка `ScenePhase`
- **Type Safety**: Повна підтримка типів Swift
- **Українські коментарі**: Зрозуміло для українських розробників
- **Debug Support**: Вбудований debug middleware
- **Generic Architecture**: Працює з будь-яким типом стану

## 📦 Вимоги

- iOS 17.0+
- SwiftUI
- ReduxCore 2.0+

## 🎯 Швидкий старт

1. ✅ **Готові компоненти**: Додайте папку `SwiftUIRedux/` → імпортуйте та використовуйте
2. 📝 **Ваша логіка**: Створіть файли з шаблонів `Templates/` → налаштуйте під ваш проект  
3. 🔗 **Залежності**: Додайте `ReduxCore` через SPM
4. 🚀 **Насолоджуйтесь Redux!**
