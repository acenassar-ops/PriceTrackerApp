# 📈 Realtime Price Tracker App

A SwiftUI demo app that streams realtime prices (mocked or via WebSocket) using **MVVM + Combine + Clean Architecture**.  
This project is intentionally lightweight, easy to read, and built for learning how to structure SwiftUI apps in a clean, testable way.  

---

## 🚀 Features

- ✅ Live price feed with start/stop controls  
- ✅ Connection status indicator  
- ✅ List of tracked symbols with realtime updates  
- ✅ Detail screen with current & previous price, delta (up/down)  
- ✅ Dark / Light Mode support  
- ✅ Reactive data flow with **Combine**  
- ✅ Unit tests with **Swift Testing** (`import Testing`)  

---

## 🏗️ Architecture

The project follows **MVVM + Clean Architecture**:

```
SwiftUI View  <->  ViewModel (ObservableObject)
                   |
                   v
             PriceFeedService (protocol)
                   |
            ------------------------
            |                      |
  MockPriceFeedService      WebSocketPriceFeedService
```

- **Models** → `SymbolQuote`, `ConnectionStatus` (simple data types)  (Domain layer)
- **Services** → `PriceFeedService` protocol + concrete implementations  (Data layer)
- **ViewModels** → handle Combine subscriptions, expose `@Published` state  (Presentation layer)
- **Views** → SwiftUI screens bound to ViewModels  (Presentation layer)

---

## 📂 Project Structure

```
PriceTrackerApp/
├─ Data/
│   ├─ Services/
│       ├─ WebSocketPriceFeedService.swift
│       ├─ RandomPriceGenerator.swift
│
├─ Domain/
│  ├─ Models/
|       ├─ SymbolQuote.swift
|       ├─ ConnectionStatus.swift
│  ├─ Protocols/
│       ├─ PriceFeedServiceProtocol.swift
│
├─ Presentation/
|  ├─ ViewModels/
|       ├─ DetailViewModel.swift
|       ├─ FeedViewModel.swift
|  ├─ Views/
|    ├─ Screens/
|       ├─ DetailView.swift
|       ├─ FeedView.swift
|    ├─ Components/
|       ├─ QuoteRowView
│
├─ Views/
│  ├─ FeedView.swift
│  ├─ DetailView.swift
│  ├─ QuoteRowView.swift
│
├─ Supporting/
│  ├─ Constants.swift
│  ├─ Helper.swift
│
└─ Tests/
   ├─ FeedViewModelTests.swift
   ├─ RandomPriceGeneratorTests.swift
   ├─ SymbolQuoteTests.swift
```

---

## 🧪 Testing

This project uses the new **Swift Testing** framework (`import Testing`) instead of XCTest.  

Run tests in Xcode with **⌘U**.  

---

## 🌓 Dark & Light Mode

The app fully supports both themes by using semantic SwiftUI colors:  

- `.primary` → adapts text for light/dark  
- `.secondary` → subtle secondary labels  
- `Color(.systemBackground)` → background color  

You can also add custom colors in the asset catalog with light/dark variants.

---

## 🔧 Requirements

- iOS 17+  
- Xcode 16+  
- Swift 5.9+  

---

## 📚 Learnings

This project is great for practicing:

- Using **Combine** for data streams in MVVM  
- Writing async-safe unit tests with `#expect(... eventually:)`  
- Applying **@ObservedObject vs @StateObject** in SwiftUI  
- Keeping SwiftUI projects **modular and clean**  

---

## 👨‍💻 Author

Built by **Christopher Nassar**  
*Senior iOS Developer | Mobile & Swift Enthusiast*  
