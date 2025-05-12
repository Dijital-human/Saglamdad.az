//
//  PhoneRule.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 05.05.25.
//

import Foundation

// MARK: - Imports
// English: Importing Foundation framework for basic functionality
// Azərbaycanca: Əsas funksionallıq üçün Foundation framework-ünün import edilməsi

// MARK: - PhoneValidationResult
// English: Structure containing phone validation results and error messages
// Azərbaycanca: Telefon yoxlama nəticələrini və xəta mesajlarını ehtiva edən strukt
struct PhoneValidationResult {
    // MARK: - Properties
    // English: Indicates if phone number is valid
    // Azərbaycanca: Telefon nömrəsinin etibarlı olub-olmadığını göstərir
    let isValid: Bool
    
    // English: Array of error messages if phone number is invalid
    // Azərbaycanca: Telefon nömrəsi etibarsızdırsa xəta mesajları massivi
    let errorMessages: [String]
    
    // MARK: - Initialization
    // English: Creates a validation result with validity status and error messages
    // Azərbaycanca: Etibarlılıq statusu və xəta mesajları ilə yoxlama nəticəsi yaradır
    init(isValid: Bool, errorMessages: [String] = []) {
        self.isValid = isValid
        self.errorMessages = errorMessages
    }
}

// MARK: - PhoneRule
// English: Class implementing phone number validation rules
// Azərbaycanca: Telefon nömrəsi yoxlama qaydalarını implementasiya edən sinif
class PhoneRule {
    // MARK: - Properties
    // English: Regular expression pattern for phone number validation
    // Azərbaycanca: Telefon nömrəsi yoxlaması üçün regular ifadə pattern-i
    private let phoneRegex = "^\\+?[1-9]\\d{1,14}$"
    
    // English: Dictionary of country codes and their lengths
    // Azərbaycanca: Ölkə kodları və onların uzunluqlarının lüğəti
    private let countryCodeLengths: [String: Int] = [
        "994": 9,  // Azerbaijan
        "90": 10,  // Turkey
        "7": 10,   // Russia
        "1": 10    // USA/Canada
    ]
    
    // MARK: - Validation Methods
    // English: Validates phone number against all rules
    // Azərbaycanca: Telefon nömrəsini bütün qaydalara görə yoxlayır
    func validatePhone(_ phone: String) -> PhoneValidationResult {
        var errorMessages: [String] = []
        
        // Check if phone is empty
        if phone.isEmpty {
            errorMessages.append("Phone number cannot be empty")
            errorMessages.append("Telefon nömrəsi boş ola bilməz")
            return PhoneValidationResult(isValid: false, errorMessages: errorMessages)
        }
        
        // Remove all non-numeric characters except '+'
        let cleanedPhone = phone.components(separatedBy: CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "+")).inverted).joined()
        
        // Check basic format using regex
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        if !phonePredicate.evaluate(with: cleanedPhone) {
            errorMessages.append("Please enter a valid phone number")
            errorMessages.append("Zəhmət olmasa düzgün telefon nömrəsi daxil edin")
            return PhoneValidationResult(isValid: false, errorMessages: errorMessages)
        }
        
        // Check country code and length
        if !isValidCountryCodeAndLength(cleanedPhone) {
            errorMessages.append("Invalid country code or phone number length")
            errorMessages.append("Yanlış ölkə kodu və ya telefon nömrəsi uzunluğu")
        }
        
        return PhoneValidationResult(isValid: errorMessages.isEmpty, errorMessages: errorMessages)
    }
    
    // MARK: - Private Methods
    // English: Validates country code and phone number length
    // Azərbaycanca: Ölkə kodunu və telefon nömrəsinin uzunluğunu yoxlayır
    private func isValidCountryCodeAndLength(_ phone: String) -> Bool {
        let phoneWithoutPlus = phone.hasPrefix("+") ? String(phone.dropFirst()) : phone
        
        for (countryCode, length) in countryCodeLengths {
            if phoneWithoutPlus.hasPrefix(countryCode) {
                // Check if the remaining digits match the expected length
                let remainingDigits = phoneWithoutPlus.count - countryCode.count
                return remainingDigits == length
            }
        }
        
        return false
    }
    
    // MARK: - Format Methods
    // English: Formats phone number for display
    // Azərbaycanca: Telefon nömrəsini göstərmək üçün formatlaşdırır
    func formatPhoneNumber(_ phone: String) -> String {
        let cleanedPhone = phone.components(separatedBy: CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "+")).inverted).joined()
        
        if cleanedPhone.hasPrefix("+994") {
            let number = String(cleanedPhone.dropFirst(4))
            if number.count >= 9 {
                let prefix = String(number.prefix(2))
                let middle = String(number[number.index(number.startIndex, offsetBy: 2)..<number.index(number.startIndex, offsetBy: 5)])
                let lastPart1 = String(number[number.index(number.startIndex, offsetBy: 5)..<number.index(number.startIndex, offsetBy: 7)])
                let lastPart2 = String(number[number.index(number.startIndex, offsetBy: 7)..<number.index(number.startIndex, offsetBy: 9)])
                return "+994 \(prefix) \(middle) \(lastPart1) \(lastPart2)"
            }
        } else if cleanedPhone.hasPrefix("+90") {
            let number = String(cleanedPhone.dropFirst(3))
            if number.count >= 10 {
                let prefix = String(number.prefix(3))
                let middle = String(number[number.index(number.startIndex, offsetBy: 3)..<number.index(number.startIndex, offsetBy: 6)])
                let last = String(number[number.index(number.startIndex, offsetBy: 6)..<number.index(number.startIndex, offsetBy: 10)])
                return "+90 \(prefix) \(middle) \(last)"
            }
        } else if cleanedPhone.hasPrefix("+7") {
            let number = String(cleanedPhone.dropFirst(2))
            if number.count >= 10 {
                let prefix = String(number.prefix(3))
                let middle = String(number[number.index(number.startIndex, offsetBy: 3)..<number.index(number.startIndex, offsetBy: 6)])
                let last = String(number[number.index(number.startIndex, offsetBy: 6)..<number.index(number.startIndex, offsetBy: 10)])
                return "+7 \(prefix) \(middle) \(last)"
            }
        } else if cleanedPhone.hasPrefix("+1") {
            let number = String(cleanedPhone.dropFirst(2))
            if number.count >= 10 {
                let prefix = String(number.prefix(3))
                let middle = String(number[number.index(number.startIndex, offsetBy: 3)..<number.index(number.startIndex, offsetBy: 6)])
                let last = String(number[number.index(number.startIndex, offsetBy: 6)..<number.index(number.startIndex, offsetBy: 10)])
                return "+1 \(prefix) \(middle) \(last)"
            }
        }
        
        return cleanedPhone
    }
}

// MARK: - String Extension
// English: Extension to help with string manipulation
// Azərbaycanca: String-in manipulyasiyası üçün extension
extension String {
    // English: Splits string into chunks of specified sizes
    // Azərbaycanca: String-i göstərilən ölçülərdə hissələrə bölür
    func chunks(ofCount counts: [Int]) -> [String] {
        var result: [String] = []
        var startIndex = self.startIndex
        
        for count in counts {
            guard startIndex < self.endIndex else { break }
            
            let endIndex = self.index(startIndex, offsetBy: count, limitedBy: self.endIndex) ?? self.endIndex
            result.append(String(self[startIndex..<endIndex]))
            startIndex = endIndex
        }
        
        return result
    }
}
