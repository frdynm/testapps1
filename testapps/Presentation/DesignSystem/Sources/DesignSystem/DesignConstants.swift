import SwiftUI

// MARK: - App Design System
public enum AppDesignSystem {

    // MARK: - Spacing
    public enum Spacing {
        public static let base: CGFloat = 8
        public static let xs: CGFloat = 4
        public static let sm: CGFloat = 8
        public static let md: CGFloat = 16
        public static let lg: CGFloat = 24
        public static let xl: CGFloat = 32
        public static let cardInner: CGFloat = 12
        public static let listRow: CGFloat = 4
    }

    // MARK: - Size
    public enum Size {
        // Images
        public static let heroImageHeight: CGFloat = 250
        public static let flagBadgeWidth: CGFloat = 60
        public static let flagBadgeHeight: CGFloat = 40
        public static let flagListWidth: CGFloat = 40
        public static let flagListHeight: CGFloat = 30

        // Corner Radius
        public static let cornerRadiusSm: CGFloat = 8
        public static let cornerRadiusMd: CGFloat = 12
        public static let cornerRadiusLg: CGFloat = 16
    }

    // MARK: - Style
    public enum Style {
        // Opacity
        public static let backgroundOpacity: Double = 0.1
        public static let placeholderOpacity: Double = 0.3
        public static let disabledOpacity: Double = 0.5

        // Text
        public static let lineSpacing: CGFloat = 6

        // Animation
        public static let fadeDuration: Double = 0.25
    }

    // MARK: - Typography
    public enum Typography {
        public static let headline = Font.headline
        public static let subheadline = Font.subheadline
        public static let body = Font.body
        public static let caption = Font.caption
        public static let title = Font.title
    }

    // MARK: - Color
    public enum Color {
        public static let primary = SwiftUI.Color.blue
        public static let secondary = SwiftUI.Color.secondary
        public static let error = SwiftUI.Color.red
        public static let success = SwiftUI.Color.green
        public static let warning = SwiftUI.Color.orange
    }
}

// MARK: - Convenience Type Aliases
public typealias AppSpacing = AppDesignSystem.Spacing
public typealias AppSize = AppDesignSystem.Size
public typealias AppStyle = AppDesignSystem.Style
