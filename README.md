# SwiftUI Redux Template

Готова Redux архітектура для SwiftUI проектів з українськими коментарями.

## 📁 Структура

```
SwiftUIRedux/
├── Store/
│   └── StoreProvider.swift      # ✅ ГОТОВИЙ: ObservableStore для SwiftUI
├── Commands/
│   └── CommandWith.swift        # ✅ ГОТОВИЙ: Command pattern
├── Lifecycle/
│   └── ApplicationState.swift   # ✅ ГОТОВИЙ: Життєвий цикл додатку
├── Debugging/
│   └── DebugLogMiddleware.swift # ✅ ГОТОВИЙ: Debug middleware
└── Templates/                   # 📝 ШАБЛОНИ ДЛЯ КОПІЮВАННЯ:
    ├── ActionsTemplate.swift    # → скопіюйте як Actions.swift
    ├── StateTemplate.swift      # → скопіюйте як AppState.swift
    ├── MiddlewareTemplate.swift # → скопіюйте як YourMiddleware.swift
    └── AppTemplate.swift        # → використайте для оновлення App.swift
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

### Крок 3: Створення вашої бізнес-логіки
Тепер створіть файли для ВАШОГО проекту, використовуючи шаблони:

1. **Створіть `Actions.swift`** - скопіюйте код з `Templates/ActionsTemplate.swift`
2. **Створіть `AppState.swift`** - скопіюйте код з `Templates/StateTemplate.swift`  
3. **Створіть ваші Middleware** - скопіюйте код з `Templates/MiddlewareTemplate.swift`
4. **Оновіть `App.swift`** - використайте код з `Templates/AppTemplate.swift`

💡 **Чому копіювати?** Templates - це стартова точка для ВАШОЇ специфічної логіки. Готові компоненти з папок `Store/`, `Commands/`, `Lifecycle/`, `Debugging/` використовуйте як є!

## 🎯 Швидкий старт

1. ✅ **Готові компоненти**: Додайте папку `SwiftUIRedux/` → імпортуйте та використовуйте
2. 📝 **Ваша логіка**: Створіть файли з шаблонів `Templates/` → налаштуйте під ваш проект  
3. 🔗 **Залежності**: Додайте `ReduxCore` через SPM
4. 🚀 **Насолоджуйтесь Redux!**
