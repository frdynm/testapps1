# testapps - Destinations App

Clean architecture iOS app untuk menampilkan destinasi wisata dengan dual bahasa (Indonesia/Inggris).

## Tech Stack

- **Language**: Swift 6, SwiftUI
- **Architecture**: Clean Architecture (MVVM + UseCase + Repository)
- **Networking**: URLSession async/await
- **Localization**: SwiftGen + Custom LocalizationManager
- **Image Loading**: AsyncImage (Kingfisher ready)
- **Dependency Injection**: Factory pattern (DI ready)

## Architecture

```
testapps/
├── Core/                          # Infrastructure Layer
│   ├── NetworkManager/           # Networking layer
│   │   └── Sources/NetworkManager/
│   │       ├── NetworkManagerProtocol.swift
│   │       └── NetworkManager.swift
│   └── LocalizationManager/      # Multi-language support
│       └── Sources/LocalizationManager/
│           ├── LocalizationManager.swift
│           ├── LocalizationManager+DI.swift
│           ├── Models/
│           │   └── Language.swift
│           └── Resources/
│               ├── en.lproj/Localizable.strings
│               ├── id.lproj/Localizable.strings
│               └── testappsStrings.generated.swift
│
├── Domain/                        # Business Logic Layer
│   └── DomainKit/
│       └── Sources/DomainKit/
│           ├── Entities/
│           │   └── DestinationEntity.swift
│           ├── Repository Protocol/
│           │   └── DestinationRepositoryProtocol.swift
│           └── UseCases/
│               └── FetchDestinationsUseCase.swift
│
├── Data/                          # Data Layer
│   └── DataKit/
│       └── Sources/DataKit/
│           ├── DTO/
│           │   └── DestinationDTO.swift
│           └── Repositories/
│               └── DestinationRepositoryImpl.swift
│
├── Presentation/                  # Presentation Layer
│   ├── DesignSystem/             # Shared design constants
│   │   └── Sources/DesignSystem/
│   │       └── DesignConstants.swift
│   ├── SharedUI/                 # Reusable UI components
│   │   └── Sources/SharedUI/Components/
│   │       ├── InfoCard.swift
│   │       └── DestinationRowView.swift
│   └── Features/
│       └── Sources/Features/Destination/
│           ├── DestinationDI.swift
│           └── Presentation/
│               └── home/
│                   ├── List/
│                   │   ├── ViewModels/
│                   │   │   └── DestinationViewModel.swift
│                   │   └── Views/
│                   │       └── DestinationListView.swift
│                   └── Detail/
│                       ├── ViewModels/
│                       │   └── DestinationDetailViewModel.swift
│                       └── Views/
│                           └── DestinationDetailView.swift
│
└── Application/                   # App Entry Point
    └── Sources/
        └── testappsApp.swift
```

## Data Flow

```
View → ViewModel → UseCase → Repository → NetworkManager → API
                                  ↓
                            DTO → Entity Mapping
```

## Features

### ✅ Destination List
- Fetch destinations dari API
- Loading state with progress view
- Error handling with retry
- Clickable rows → detail page

### ✅ Destination Detail
- Hero image dengan flag badge
- Info cards (Population, Price, Latitude, Longitude)
- Photographer credit
- Full description

### ✅ Dual Bahasa
- **English** & **Bahasa Indonesia**
- Type-safe string access via `testappsStrings`
- SwiftGen auto-generated strings
- Runtime language switching

### ✅ Clean Code
- **No hardcoded values** - DesignConstants with AppSpacing/AppSize/AppStyle
- **MVVM pattern** - ViewModels handle business logic
- **Reusable components** - SharedUI for InfoCard, DestinationRowView
- **Dependency Injection ready** - Factory pattern in place

## Setup

### 1. Install SwiftGen
```bash
brew install swiftgen
```

### 2. Add Build Phase in Xcode
```bash
open testapps.xcodeproj
```

In Xcode:
1. Target → Build Phases → New Run Script Phase
2. Paste:
```bash
if which swiftgen > /dev/null; then
  swiftgen config run --config swiftgen.yml
else
  echo "warning: SwiftGen not installed"
fi
```

### 3. Add Files to Target
Select all folders → File Inspector → Target Membership → Check **testapps**

### 4. Build
```bash
# Clean build
rm -rf ~/Library/Developer/Xcode/DerivedData/testapps-*

# In Xcode: ⌘⇧K → ⌘B
```

## Usage

### Localization
```swift
// Basic string
Text(testappsStrings.destinationsTitle)

// With parameter
testappsStrings.detailPhotographer("John Doe")
// → "Photo by John Doe" / "Foto oleh John Doe"

// Switch language
LocalizationContainer.shared().setLanguage(.id) // Indonesia
LocalizationContainer.shared().setLanguage(.en) // English
```

### Design System
```swift
// Spacing
.padding(AppSpacing.md)
.frame(height: AppSize.heroImageHeight)

// Style
.background(.blue.opacity(AppStyle.backgroundOpacity))
```

### Add New Strings
1. Edit `Localizable.strings` in both `en.lproj` and `id.lproj`
2. Run `swiftgen`
3. Use `testappsStrings.yourNewKey`

## API

**Endpoint:** `https://www.hackingwithswift.com/samples/journeys/destinations.json`

**Response:** Array of destinations dengan id, country, photographer, price, population, coordinates, description, imageURL, flagURL

## Optional Enhancements

- [ ] Add Kingfisher package for advanced image caching
- [ ] Setup DesignSystem as separate target
- [ ] Setup SharedUI as separate target  
- [ ] Add unit tests for each layer
- [ ] Implement proper DI container (FactoryKit)
- [ ] Add more languages
- [ ] Add offline caching with CoreData
- [ ] Implement deep linking
