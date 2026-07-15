import Foundation

// MARK: - Dependency Injection (temporary)
// TODO: Implement proper DI container when ready
public enum LocalizationContainer {
    public static func shared() -> LocalizationManager {
        .shared
    }
}

extension LocalizationManager {
    static let shared = LocalizationManager()
}
