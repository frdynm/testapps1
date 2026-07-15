import Foundation

public enum Language: String, CaseIterable {
    case en  // English
    case id  // Bahasa Indonesia
    
    public var displayName: String {
        switch self {
        case .en: "English"
        case .id: "Bahasa Indonesia"
        }
    }
    
    public var locale: Locale {
        Locale(identifier: rawValue)
    }
    
    public static var systemLanguage: Language {
        let defaultLanguage = "id"
        return Language(rawValue: defaultLanguage) ?? .id
    }
}
