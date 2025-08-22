# SwiftUI Redux Template

Готова Redux архітектура для SwiftUI проектів з українськими коментарями.

## 📁 Структура

```
SwiftUIRedux/
├── Store/
│   └── StoreProvider.swift      # ObservableStore для SwiftUI інтеграції
├── Commands/
│   └── CommandWith.swift        # Command pattern для функціонального програмування
├── Lifecycle/
│   └── ApplicationState.swift   # Життєвий цикл додатку (ScenePhase)
├── Debugging/
│   └── DebugLogMiddleware.swift # Debug middleware для розробки
└── Templates/
    ├── ActionsTemplate.swift    # Шаблон для дій (Actions)
    ├── StateTemplate.swift      # Шаблон для станів (States)  
    ├── MiddlewareTemplate.swift # Шаблон для middleware
    └── AppTemplate.swift        # Шаблон для App.swift
```

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

### Крок 3: Створення вашої архітектури
1. Actions.swift - скопіюйте з Templates/ActionsTemplate.swift
2. State.swift - скопіюйте з Templates/StateTemplate.swift
3. Middleware - скопіюйте з Templates/MiddlewareTemplate.swift
4. App.swift - скопіюйте з Templates/AppTemplate.swift

## 🎯 Швидкий старт

1. Скопіюйте папку SwiftUIRedux/ в ваш проект
2. Додайте залежність ReduxCore через SPM
3. Використовуйте шаблони з Templates/
4. Насолоджуйтесь Redux! 🚀
