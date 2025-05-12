import Foundation

// MARK: - ValidationServiceProtocol
// English: Protocol defining validation service requirements
// Azərbaycanca: Validasiya xidmətinin tələblərini müəyyən edən protokol
protocol ValidationServiceProtocol {
    func isValidEmail(_ email: String) -> Bool
    func isValidPassword(_ password: String) -> Bool
}

// MARK: - ValidationService
// English: Implementation of validation service
// Azərbaycanca: Validasiya xidmətinin implementasiyası
final class ValidationService: ValidationServiceProtocol {
    func isValidEmail(_ email: String) -> Bool {
        let emailPred = NSPredicate(format: "SELF MATCHES %@", AppConstants.Validation.emailRegex)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= AppConstants.Validation.passwordMinLength
    }
} 