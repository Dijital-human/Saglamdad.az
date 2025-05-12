import SwiftUI

// MARK: - AppConstants
// English: Constants used throughout the application
// Azərbaycanca: Tətbiq boyunca istifadə olunan sabitlər
enum AppConstants {
    // MARK: - Fonts
    enum Fonts {
        static let primary = "Georgia"
        static let titleSize: CGFloat = 18
        static let bodySize: CGFloat = 12
        static let captionSize: CGFloat = 10
    }
    
    // MARK: - Colors
    enum Colors {
        static let primary = Color.blue
        static let secondary = Color.white
        static let background = Color.black.opacity(0.3)
        static let textPrimary = Color.white
        static let textSecondary = Color.white.opacity(0.7)
    }
    
    // MARK: - Layout
    enum Layout {
        static let cornerRadius: CGFloat = 12
        static let buttonHeight: CGFloat = 44
        static let spacing: CGFloat = 10
        static let padding: CGFloat = 20
    }
    
    // MARK: - Animation
    enum Animation {
        static let spring = SwiftUI.Animation.spring(
            response: 0.6,
            dampingFraction: 0.6,
            blendDuration: 0.5
        )
        static let delay: Double = 0.9
    }
    
    // MARK: - Validation
    enum Validation {
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let passwordMinLength = 8
    }
} 