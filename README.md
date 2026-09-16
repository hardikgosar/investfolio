# Investfolio 📈

A Flutter-based investment portfolio application built with **Clean Architecture, BLoC, Repository Pattern, and responsive UI**.

## Features

* Portfolio summary and total value
* Portfolio performance chart
* Asset allocation chart
* Holdings with profit/loss
* Recent transactions
* Explore investments
* Profile screen
* Custom in-app browser using WebView
* Loading, error, and empty states
* Responsive and adaptive UI

## Tech Stack

* **Flutter / Dart**
* **BLoC + Equatable**
* **Clean Architecture**
* **Repository Pattern**
* **GoRouter**
* **FL Chart**
* **WebView**
* **Local JSON Mock API**

## Architecture

```text
Presentation
     ↓
   BLoC
     ↓
  UseCase
     ↓
 Repository
     ↓
 DataSource
     ↓
 Local JSON
```

Portfolio data flow:

```text
PortfolioScreen
      ↓
PortfolioBloc
      ↓
GetPortfolioUseCase
      ↓
PortfolioRepository
      ↓
PortfolioLocalDataSource
      ↓
assets/mock_api/portfolio.json
```

The repository abstraction allows the local JSON data source to be replaced with a REST API without changing the presentation or domain layers.

## Project Structure

```text
lib/
├── core/
│   ├── constants/
│   ├── error/
│   ├── routes/
│   ├── theme/
│   └── widgets/
│
├── features/
│   ├── dashboard/
│   ├── explore/
│   ├── portfolio/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── profile/
│   └── webview/
│
└── main.dart
```

## Mock API

Portfolio data is stored locally at:

```text
assets/mock_api/portfolio.json
```

No external backend is required to run the application.

## Getting Started

```bash
flutter pub get
flutter run
```

## Key Design Decisions

* **BLoC** for predictable and testable state management.
* **Clean Architecture** to separate UI, business logic, and data access.
* **Repository Pattern** to abstract the data source.
* **Equatable** to reduce unnecessary state updates.
* **Local JSON** to simulate an API without requiring a backend.
* **Responsive UI** to support different screen sizes.


# investfolio
