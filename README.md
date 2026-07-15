# Clean Architecture Structure

```
testapps/
├── Core/                          # Infrastructure Layer
│   └── NetworkManager/
│       ├── Sources/NetworkManager/
│       │   ├── NetworkManagerProtocol.swift
│       │   └── NetworkManager.swift
│       └── Tests/NetworkManagerTests/
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
│   └── Features/
│       └── Sources/Features/Destination/
│           ├── DestinationDI.swift
│           └── Presentation/
│               ├── ViewModels/
│               │   └── DestinationViewModel.swift
│               └── Views/
│                   └── DestinationListView.swift
│
├── Application/                   # App Entry Point
│   └── Sources/
│       ├── testappsApp.swift
│       └── Info.plist
│
└── Resources/                     # Assets, Localization, etc.
```

## Setup Instructions

### 1. Add Files to Xcode Target
```bash
open testapps.xcodeproj
```

In Xcode:
1. Select all created folders/files
2. In File Inspector → Target Membership → Check "testapps"
3. Clean Build Folder (⌘⇧K)
4. Build (⌘B)

### 2. Clean Build If Needed
```bash
rm -rf ~/Library/Developer/Xcode/DerivedData/testapps-*
```

## Architecture Overview

**Flow:** View → ViewModel → UseCase → Repository → NetworkManager → API

- **Core**: Reusable infrastructure (Network, Cache, Storage)
- **Domain**: Pure business logic (no dependencies on Data/Presentation)
- **Data**: API/DB implementation, DTO → Entity mapping
- **Presentation**: UI layer with MVVM pattern
- **Application**: Composition root, app lifecycle
