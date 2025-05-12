//
//  EmailRule.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 05.05.25.
//

import Foundation

// MARK: - EmailValidationResult
// English: Structure containing email validation results and error messages
// Azərbaycanca: Email yoxlama nəticələrini və xəta mesajlarını ehtiva edən strukt
struct EmailValidationResult {
    // MARK: - Properties
    // English: Indicates if email is valid
    // Azərbaycanca: Email-in etibarlı olub-olmadığını göstərir
    let isValid: Bool
    
    // English: Array of error messages if email is invalid
    // Azərbaycanca: Email etibarsızdırsa xəta mesajları massivi
    let errorMessages: [String]
    
    // MARK: - Initialization
    // English: Creates a validation result with validity status and error messages
    // Azərbaycanca: Etibarlılıq statusu və xəta mesajları ilə yoxlama nəticəsi yaradır
    init(isValid: Bool, errorMessages: [String] = []) {
        self.isValid = isValid
        self.errorMessages = errorMessages
    }
}

// MARK: - EmailRule
// English: Class implementing email validation rules
// Azərbaycanca: Email yoxlama qaydalarını implementasiya edən sinif
class EmailRule {
    // MARK: - Properties
    // English: Regular expression pattern for email validation
    // Azərbaycanca: Email yoxlaması üçün regular ifadə pattern-i
    private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    // MARK: - Validation Methods
    // English: Validates email against all rules
    // Azərbaycanca: Email-i bütün qaydalara görə yoxlayır
    func validateEmail(_ email: String) -> EmailValidationResult {
        var errorMessages: [String] = []
        
        // Check if email is empty
        if email.isEmpty {
            errorMessages.append("Email cannot be empty")
            errorMessages.append("Email boş ola bilməz")
            return EmailValidationResult(isValid: false, errorMessages: errorMessages)
        }
        
        // Check email format using regex
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: email) {
            errorMessages.append("Please enter a valid email address")
            errorMessages.append("Zəhmət olmasa düzgün email ünvanı daxil edin")
        }
        
        // Check for minimum length
        if email.count < 5 {
            errorMessages.append("Email must be at least 5 characters long")
            errorMessages.append("Email ən azı 5 simvol uzunluğunda olmalıdır")
        }
        
        // Check for maximum length
        if email.count > 254 {
            errorMessages.append("Email cannot exceed 254 characters")
            errorMessages.append("Email 254 simvoldan çox ola bilməz")
        }
        
        // Check for valid domain
        if !isValidDomain(email) {
            errorMessages.append("Please enter a valid email domain")
            errorMessages.append("Zəhmət olmasa düzgün email domeni daxil edin")
        }
        
        return EmailValidationResult(isValid: errorMessages.isEmpty, errorMessages: errorMessages)
    }
    
    // MARK: - Private Methods
    // English: Validates email domain
    // Azərbaycanca: Email domenini yoxlayır
    private func isValidDomain(_ email: String) -> Bool {
        let components = email.components(separatedBy: "@")
        guard components.count == 2 else { return false }
        
        let domain = components[1]
        let domainComponents = domain.components(separatedBy: ".")
        
        // Check if domain has at least two parts
        guard domainComponents.count >= 2 else { return false }
        
        // Check if domain parts are not empty
        for component in domainComponents {
            if component.isEmpty {
                return false
            }
        }
        
        return true
    }
}
