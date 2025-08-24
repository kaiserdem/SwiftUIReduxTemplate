# SwiftUI Redux Template

Готова Redux архітектура для SwiftUI проектів

## 📁 Структура

```
    SwiftUIRedux/
├── Store/
│ ├── StoreProvider.swift # ✅ ГОТОВИЙ: ObservableStore для SwiftUI
│ └── StateReducer.swift # ✅ НОВИЙ: Протокол StateReducer
├── Commands/
│ └── CommandWith.swift # ✅ ГОТОВИЙ: Command pattern
├── Lifecycle/
│ └── ApplicationState.swift # ✅ ГОТОВИЙ: Життєвий цикл додатку
└── Debugging/
    └── DebugLogMiddleware.swift # ✅ ГОТОВИЙ: Debug middleware

TemplateTest/ # 🚀 ГОТОВИЙ ПРИКЛАД ВИКОРИСТАННЯ
├── Core/
│ ├── Actions/
│ │ └── Actions.swift # Приклад Actions з новою архітектурою
│ ├── State/
│ │ └── AppState.swift # Приклад AppState з протоколом StateReducer
│ └── Middleware/
│     └── APIMiddleware.swift # Приклад middleware
└── Views/
    └── CounterView.swift # Приклад View з Redux
```

### 🔍 Пояснення структури:

**✅ Готові компоненти** - використовуйте як є, імпортуйте в свій код  
**🚀 TemplateTest** - готовий робочий приклад нової архітектури

## 🆕 Нова архітектура

### Протокол StateReducer
**Розташування:** `SwiftUIRedux/Store/StateReducer.swift`

```swift
public protocol StateReducer {
    associatedtype State
    
    // Новий підхід: змінюємо стан напряму
    static func stateReduce(into state: inout State, action: any Action)
}

// Автоматична композиція reducer'ів
public extension StateReducer where Self == State {
    static func reduce(_ state: State, with action: any Action) -> State {
        var newState = state
        
        // Автоматично викликаємо stateReduce для композиції
        stateReduce(into: &newState, action: action)
        
        return newState
    }
}
```

### Переваги нової архітектури:
- ✅ **Менше дублювання** - не потрібно створювати нові об'єкти в кожному case
- ✅ **Простота** - `stateReduce(into:)` змінює стан напряму
- ✅ **Ефективність** - менше алокацій пам'яті
- ✅ **Автоматична композиція** - reducer'и автоматично об'єднуються
- ✅ **TCA стиль** - функціональна композиція з простим синтаксисом

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

### Крок 3: Створення вашої бізнес-логіки
Тепер створіть файли для ВАШОГО проекту, використовуючи готовий приклад:

1. **Створіть `Actions.swift`** - скопіюйте код з `TemplateTest/Core/Actions/Actions.swift`
2. **Створіть `AppState.swift`** - скопіюйте код з `TemplateTest/Core/State/AppState.swift`  
3. **Створіть ваші Middleware** - скопіюйте код з `TemplateTest/Core/Middleware/APIMiddleware.swift`
4. **Оновіть `App.swift`** - використайте код з `TemplateTest/App/TemplateTestApp.swift`

💡 **Чому копіювати з TemplateTest?** Це готовий робочий приклад нової архітектури!

## 💻 Приклад використання  архітектури

### Actions.swift
```swift
import Foundation
import ReduxCore

enum Actions {
    struct StartLoading: Action {}
    struct LoadingFinished: Action { let items: [String] }
    struct AddItem: Action {} 
    struct ClearItems: Action {}
}
```

### AppState.swift
```swift
import Foundation
import ReduxCore

struct AppState: StateReducer {
    typealias State = AppState
    
    let application: ApplicationState
    var isLoading: Bool
    var items: [String]
    let errorMessage: String?
    
    static let initial = State(
        application: ApplicationState.initial,
        isLoading: false,
        items: [],
        errorMessage: nil
    )
    
    static func stateReduce(into state: inout AppState, action: any Action) {
        switch action {
        case is Actions.StartLoading:
            state.isLoading = true
            
        case let action as Actions.LoadingFinished:
            state.isLoading = false
            state.items = state.items + action.items
            
        case is Actions.AddItem: 
            let newItem = "Item \(state.items.count + 1)"
            state.items = state.items + [newItem]
            
        case is Actions.ClearItems:
            state.items = []
            
        default:
            break
        }
    }
}
```

### App.swift
```swift
import SwiftUI
import ReduxCore

@main
struct YourApp: App {
    private let store = ObservableStore<AppState>(
        store: Store<AppState>(
            state: AppState.initial,
            reducer: AppState.reduce, 
            middlewares: [
                DebugLogMiddleware<AppState>().middleware()
            ]
        )
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.appStore, store)
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
    @Environment(\.appStore) private var store: ObservableStore<AppState>?
    
    var body: some View {
        VStack(spacing: 20) {
            if let store = store {
                Text("App State: \(store.state.application == .active ? "Active" : "Inactive")")
                Text("Items count: \(store.state.items.count)")
                
                Button("Start Loading") {
                    store.dispatch(action: Actions.StartLoading())
                }
                
                Button("Add Item") {
                    store.dispatch(action: Actions.AddItem()) 
                }
                
                Button("Clear Items") {
                    store.dispatch(action: Actions.ClearItems())
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

## ✨ Переваги нової архітектури

- **🚀 Простота**: `stateReduce(into:)` без дублювання коду
- **⚡ Ефективність**: менше алокацій пам'яті
- **🔄 Автоматична композиція**: reducer'и автоматично об'єднуються
- **🎯 TCA стиль**: функціональна композиція з простим синтаксисом
- **🔒 Типобезпека**: повна підтримка типів Swift
- **🐛 Debug Support**: вбудований debug middleware

## 📦 Вимоги

- iOS 17.0+
- SwiftUI
- ReduxCore 2.0+

## 🎯 Швидкий старт

1. ✅ **Готові компоненти**: Додайте папку `SwiftUIRedux/` → імпортуйте та використовуйте
2. 🚀 **Ваша логіка**: Скопіюйте код з `TemplateTest/` → налаштуйте під ваш проект  
3. 🔗 **Залежності**: Додайте `ReduxCore` через SPM
4. 🚀 **Насолоджуйтесь новою Redux архітектурою!**
