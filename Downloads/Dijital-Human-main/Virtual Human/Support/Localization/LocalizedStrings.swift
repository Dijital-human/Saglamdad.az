import Foundation

// MARK: - LocalizedStrings
// English: Localization strings used throughout the application
// Azərbaycanca: Tətbiq boyunca istifadə olunan lokalizasiya mətnləri
enum LocalizedStrings {
    // MARK: - Authentication
    enum Auth {
        static let signIn = NSLocalizedString("Sign In", comment: "Sign in button title")
        static let forgotPassword = NSLocalizedString("Forgot Password?", comment: "Forgot password button title")
        static let continueWith = NSLocalizedString("Or continue with", comment: "Social login section title")
        
        // Error Messages
        static let emailRequired = NSLocalizedString("Email is required", comment: "Email validation error")
        static let invalidEmail = NSLocalizedString("Invalid email format", comment: "Email format validation error")
        static let passwordRequired = NSLocalizedString("Password is required", comment: "Password validation error")
        static let invalidPassword = NSLocalizedString("Password must be at least 8 characters", comment: "Password length validation error")
    }
    
    // MARK: - Social Media
    enum Social {
        static let apple = NSLocalizedString("Apple", comment: "Apple login button title")
        static let google = NSLocalizedString("Google", comment: "Google login button title")
        static let facebook = NSLocalizedString("Facebook", comment: "Facebook login button title")
        static let twitter = NSLocalizedString("Twitter", comment: "Twitter login button title")
    }
} 