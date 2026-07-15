# SwiftGen + VelloString Setup Guide

## Installation

### 1. Install SwiftGen
```bash
brew install swiftgen
```

### 2. Add Build Phase to Xcode
In Xcode:
1. Select target → Build Phases
2. Add New Run Script Phase
3. Paste:
```bash
if which swiftgen > /dev/null; then
  swiftgen config run --config swiftgen.yml
else
  echo "warning: SwiftGen not installed. Run 'brew install swiftgen'"
fi
```

## Structure Created

```
testapps/
├── Core/
│   └── LocalizationManager/
│       └── Sources/LocalizationManager/
│           ├── LocalizationManager.swift
│           ├── LocalizationManager+DI.swift
│           ├── Models/
│           │   └── Language.swift
│           └── Resources/
│               ├── en.lproj/Localizable.strings
│               ├── id.lproj/Localizable.strings
│               └── testappsStrings.generated.swift (generated)
├── scripts/
│   └── SwiftgenTemplates/
│       └── Localization.stencil
└── swiftgen.yml
```

## Usage

### After Running SwiftGen
```bash
swiftgen config run
```

Generated `testappsStrings.generated.swift`:
```swift
public enum testappsStrings {
  public static var appName: String { ... }
  public static var generalLoading: String { ... }
  public static func detailPhotographer(_ p1: Any) -> String { ... }
}
```

### In SwiftUI Views
```swift
import LocalizationManager

struct DestinationListView: View {
    var body: some View {
        Text(testappsStrings.destinationsTitle)
        ProgressView(testappsStrings.generalLoading)
        Button(testappsStrings.generalRetry) { }
    }
}
```

### With Parameters
```swift
let photographer = "John Doe"
Text(testappsStrings.detailPhotographer(photographer))
// "Foto oleh John Doe"
```

### Add New Strings

**en.lproj/Localizable.strings:**
```
"new.key" = "New Value";
"new.key.with.param" = "Hello %@";
```

**Run:** `swiftgen config run`

**Use:**
```swift
testappsStrings.newKey
testappsStrings.newKeyWithParam("World")
```

## Switch Languages

```swift
LocalizationContainer.shared().setLanguage(.en) // English
LocalizationContainer.shared().setLanguage(.id) // Bahasa Indonesia
```

## Features

✅ Type-safe string access
✅ Compile-time checking
✅ IDE autocompletion
✅ Parameter support
✅ Multi-language support (English/Indonesian)
✅ Custom SwiftGen template
✅ Dependency injection ready
