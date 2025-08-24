# SwiftUI Redux Template

Готова модульна Redux архітектура для SwiftUI проектів 

## 📁 Структура

```
    SwiftUIRedux/
├── Store/
│ ├── StoreProvider.swift
│ └── StateReducer.swift
├── Commands/
│ └── CommandWith.swift
├── Lifecycle/
│ └── ApplicationState.swift
└── Debugging/
    └── DebugLogMiddleware.swift 

TemplateTest/ # 🚀 ГОТОВИЙ ПРИКЛАД ВИКОРИСТАННЯ
├── Features/ 
│ └── Counter/ 
│     ├── Actions/
│     │ └── CounterActions.swift 
│     ├── State/
│     │ └── CounterState.swift 
│     ├── Middleware/
│     │ └── APIMiddleware.swift
│     └── Views/
│         └── CounterView.swift 
├── App/
│ ├── TemplateTestApp.swift 
│ └── CounterStateStoreKey.swift
└── Assets.xcassets/ 
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

1. **Створіть `Actions.swift`** - скопіюйте код з `TemplateTest/Features/Actions/Actions.swift`
2. **Створіть `AppState.swift`** - скопіюйте код з `TemplateTest/Features/State/AppState.swift`  
3. **Створіть ваші Middleware** - скопіюйте код з `TemplateTest/Features/Middleware/APIMiddleware.swift`
4. **Створіть `AppStateStoreKey.swift`** - скопіюйте код з `TemplateTest/App/AppStateStoreKey.swift`
5. **Оновіть `App.swift`** - використайте код з `TemplateTest/App/TemplateTestApp.swift`

## 💻 Приклад використання архітектури

### Actions.swift
```swift
import Foundation
import ReduxCore

enum CounterActions {
    struct StartLoading: Action {}
    struct LoadingFinished: Action { let items: [String] }
    struct AddSingleItem: Action {}    
    struct ClearItems: Action {}    
}
```

### AppState.swift
```swift
import Foundation
import ReduxCore

struct CounterState: StateReducer {
    typealias State = CounterState
    
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
    
    static func stateReduce(into state: inout CounterState, action: any Action) {
        switch action {
        case is CounterActions.StartLoading:
            state.isLoading = true
            
        case let action as CounterActions.LoadingFinished:
            state.isLoading = false
            state.items = state.items + action.items
            
        case _ as CounterActions.AddSingleItem:
            let newItem = "Item \(state.items.count + 1)"
            state.items = state.items + [newItem]
            
        case is CounterActions.ClearItems:
            state.items = []
            
        default:
            break
        }
    }
}
```

### AppStateStoreKey.swift
```swift
import Foundation
import ReduxCore
import SwiftUI

struct CounterStateStoreKey: EnvironmentKey {
    static var defaultValue: ObservableStore<CounterState>? = nil
}

extension EnvironmentValues {
    var counterStateStore: ObservableStore<CounterState>? {
        get { self[CounterStateStoreKey.self] }
        set { self[CounterStateStoreKey.self] = newValue }
    }
}
```

### App.swift
```swift
import SwiftUI
import ReduxCore

@main
struct TemplateTestApp: App {
    private let store = ObservableStore<CounterState>(
        store: Store<CounterState>(
            state: CounterState.initial,
            reducer: CounterState.reduce,
            middlewares: [
                DebugLogMiddleware<CounterState>().middleware(),
                               APICounterMiddleware().middleware()
            ]
        )
    )
    
    var body: some Scene {
        WindowGroup {
            CounterView()
            .environment(\.counterStateStore, store)
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
struct CounterView: View {
    @Environment(\.counterStateStore) private var store: ObservableStore<CounterState>?
    
    var body: some View {
           VStack(spacing: 20) {
               if let store = store {
                   
                   if store.state.isLoading {
                       ProgressView()
                   } else {
                       Text("App is: \(store.state.application == .active ? "Active" : "Inactive")")
                       
                   }
                   Text("Items count: \(store.state.items.count)")
                   
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

struct CounterButtonStyle: ViewModifier { // Просто приклад зручного використання ViewModifier для мненьшення коду в прикладі
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .border(.gray)
        
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
