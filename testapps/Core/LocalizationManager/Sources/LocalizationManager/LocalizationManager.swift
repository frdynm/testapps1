import Foundation
import Combine

public final class LocalizationManager: ObservableObject {
    @Published public private(set) var currentLanguage: Language = .systemLanguage
    
    public init() {}
    
    // MARK: - Public Methods
    public func localizedString(for key: String) -> String {
        let bundle = Bundle.localizedModule(for: currentLanguage)
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
    
    public func localizedString(for key: String, arguments: CVarArg...) -> String {
        let format = localizedString(for: key)
        return String(format: format, locale: currentLanguage.locale, arguments: arguments)
    }
    
    // MARK: - Language Switching
    public func setLanguage(_ language: Language) {
        currentLanguage = language
    }
}

// MARK: - Bundle Extension
public extension Bundle {
    static func localizedModule(for language: Language) -> Bundle {
        // Try to find the language bundle in the main bundle
        if let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return bundle
        }
        // Fallback to main bundle
        return Bundle.main
    }
}
