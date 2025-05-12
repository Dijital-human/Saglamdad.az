//
//  PasswordRulesProtocol.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 05.05.25.
//

import Foundation

// MARK: - PasswordRulesProtocol
// English: Protocol defining password validation rules and requirements
// Azərbaycanca: Şifrə yoxlama qaydalarını və tələblərini təyin edən protokol
protocol PasswordRulesProtocol {
    // MARK: - Password Requirements
    // English: Minimum password length requirement
    // Azərbaycanca: Minimum şifrə uzunluğu tələbi
    var minimumLength: Int { get }
    
    // English: Maximum password length requirement
    // Azərbaycanca: Maksimum şifrə uzunluğu tələbi
    var maximumLength: Int { get }
    
    // English: Requirement for uppercase letters
    // Azərbaycanca: Böyük hərflər tələbi
    var requiresUppercase: Bool { get }
    
    // English: Requirement for lowercase letters
    // Azərbaycanca: Kiçik hərflər tələbi
    var requiresLowercase: Bool { get }
    
    // English: Requirement for numbers
    // Azərbaycanca: Rəqəmlər tələbi
    var requiresNumbers: Bool { get }
    
    // English: Requirement for special characters
    // Azərbaycanca: Xüsusi simvollar tələbi
    var requiresSpecialCharacters: Bool { get }
    
    // MARK: - Validation Methods
    // English: Validates password against all rules
    // Azərbaycanca: Şifrəni bütün qaydalara görə yoxlayır
    func validatePassword(_ password: String) -> PasswordValidationResult
}

// MARK: - PasswordValidationResult
// English: Structure containing password validation results and error messages
// Azərbaycanca: Şifrə yoxlama nəticələrini və xəta mesajlarını ehtiva edən strukt
struct PasswordValidationResult {
    // MARK: - Properties
    // English: Indicates if password is valid
    // Azərbaycanca: Şifrənin etibarlı olub-olmadığını göstərir
    let isValid: Bool
    
    // English: Array of error messages if password is invalid
    // Azərbaycanca: Şifrə etibarsızdırsa xəta mesajları massivi
    let errorMessages: [String]
    
    // MARK: - Initialization
    // English: Creates a validation result with validity status and error messages
    // Azərbaycanca: Etibarlılıq statusu və xəta mesajları ilə yoxlama nəticəsi yaradır
    init(isValid: Bool, errorMessages: [String] = []) {
        self.isValid = isValid
        self.errorMessages = errorMessages
    }
}

// MARK: - DefaultPasswordRules
// English: Default implementation of password rules
// Azərbaycanca: Şifrə qaydalarının standart implementasiyası
struct DefaultPasswordRules: PasswordRulesProtocol {
    // MARK: - Password Requirements Implementation
    // English: Minimum password length set to 8 characters
    // Azərbaycanca: Minimum şifrə uzunluğu 8 simvol olaraq təyin edilib
    var minimumLength: Int { return 8 }
    
    // English: Maximum password length set to 32 characters
    // Azərbaycanca: Maksimum şifrə uzunluğu 32 simvol olaraq təyin edilib
    var maximumLength: Int { return 32 }
    
    // English: Requires at least one uppercase letter
    // Azərbaycanca: Ən azı bir böyük hərf tələb edir
    var requiresUppercase: Bool { return true }
    
    // English: Requires at least one lowercase letter
    // Azərbaycanca: Ən azı bir kiçik hərf tələb edir
    var requiresLowercase: Bool { return true }
    
    // English: Requires at least one number
    // Azərbaycanca: Ən azı bir rəqəm tələb edir
    var requiresNumbers: Bool { return true }
    
    // English: Requires at least one special character
    // Azərbaycanca: Ən azı bir xüsusi simvol tələb edir
    var requiresSpecialCharacters: Bool { return true }
    
    // MARK: - Validation Implementation
    // English: Validates password against all rules and returns result
    // Azərbaycanca: Şifrəni bütün qaydalara görə yoxlayır və nəticəni qaytarır
    func validatePassword(_ password: String) -> PasswordValidationResult {
        var errorMessages: [String] = []
        
        // Check minimum length
        if password.count < minimumLength {
            errorMessages.append("Password must be at least \(minimumLength) characters long")
            errorMessages.append("Şifrə ən azı \(minimumLength) simvol uzunluğunda olmalıdır")
        }
        
        // Check maximum length
        if password.count > maximumLength {
            errorMessages.append("Password cannot exceed \(maximumLength) characters")
            errorMessages.append("Şifrə \(maximumLength) simvoldan çox ola bilməz")
        }
        
        // Check for uppercase letters
        if requiresUppercase && !password.contains(where: { $0.isUppercase }) {
            errorMessages.append("Password must contain at least one uppercase letter")
            errorMessages.append("Şifrə ən azı bir böyük hərf ehtiva etməlidir")
        }
        
        // Check for lowercase letters
        if requiresLowercase && !password.contains(where: { $0.isLowercase }) {
            errorMessages.append("Password must contain at least one lowercase letter")
            errorMessages.append("Şifrə ən azı bir kiçik hərf ehtiva etməlidir")
        }
        
        // Check for numbers
        if requiresNumbers && !password.contains(where: { $0.isNumber }) {
            errorMessages.append("Password must contain at least one number")
            errorMessages.append("Şifrə ən azı bir rəqəm ehtiva etməlidir")
        }
        
        // Check for special characters
        if requiresSpecialCharacters && !password.contains(where: { !$0.isLetter && !$0.isNumber }) {
            errorMessages.append("Password must contain at least one special character")
            errorMessages.append("Şifrə ən azı bir xüsusi simvol ehtiva etməlidir")
        }
        
        return PasswordValidationResult(isValid: errorMessages.isEmpty, errorMessages: errorMessages)
    }
}
