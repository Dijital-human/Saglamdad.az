//
//  ErrorManager.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 04.05.25.
//

import Foundation

/**
 # ErrorManager
 ## English
 Manages and handles all error messages in the application.
 Provides localized error messages in both English and Azerbaijani.
 Centralizes error handling for better maintainability.
 
 ## Azərbaycanca
 Tətbiqdəki bütün xəta mesajlarını idarə edir.
 İngilis və Azərbaycan dillərində lokalizasiya edilmiş xəta mesajları təqdim edir.
 Daha yaxşı idarəetmə üçün xəta idarəetməsini mərkəzləşdirir.
 */
enum ErrorType {
    /**
     ## English
     Authentication related errors.
     Covers all possible authentication scenarios.
     
     ## Azərbaycanca
     Autentifikasiya ilə əlaqəli xətalar.
     Bütün mümkün autentifikasiya ssenarilərini əhatə edir.
     */
    case emptyEmail
    case emptyPassword
    case invalidEmail
    case wrongPassword
    case userNotFound
    case userDisabled
    case networkError
    case unknownError
    case emailAlreadyInUse
    case weakPassword
    case operationNotAllowed
    case tooManyRequests
    
    /**
     ## English
     Database related errors.
     Covers Firestore operations and data management.
     
     ## Azərbaycanca
     Verilənlər bazası ilə əlaqəli xətalar.
     Firestore əməliyyatları və məlumat idarəetməsini əhatə edir.
     */
    case documentNotFound
    case dataCorrupted
    case permissionDenied
    case quotaExceeded
    case unauthenticated
    case invalidArgument
}

/**
 # ErrorManager
 ## English
 Provides error messages based on error type.
 Supports multiple languages and error scenarios.
 
 ## Azərbaycanca
 Xəta növünə əsasən xəta mesajları təqdim edir.
 Çoxlu dillər və xəta ssenarilərini dəstəkləyir.
 */
class ErrorManager {
    /**
     ## English
     Returns localized error message based on error type.
     Supports both English and Azerbaijani languages.
     
     ## Azərbaycanca
     Xəta növünə əsasən lokalizasiya edilmiş xəta mesajı qaytarır.
     Həm İngilis, həm də Azərbaycan dillərini dəstəkləyir.
     */
    static func getErrorMessage(_ type: ErrorType) -> String {
        switch type {
        // Authentication Errors
        case .emptyEmail:
            return "Email cannot be empty" // "Email boş ola bilməz"
        case .emptyPassword:
            return "Password cannot be empty" // "Şifrə boş ola bilməz"
        case .invalidEmail:
            return "Please enter a valid email address" // "Zəhmət olmasa düzgün email ünvanı daxil edin"
        case .wrongPassword:
            return "Incorrect password" // "Yanlış şifrə"
        case .userNotFound:
            return "User not found" // "İstifadəçi tapılmadı"
        case .userDisabled:
            return "This account has been disabled" // "Bu hesab deaktiv edilib"
        case .networkError:
            return "Network error. Please check your connection" // "Şəbəkə xətası. Zəhmət olmasa bağlantınızı yoxlayın"
        case .unknownError:
            return "An unknown error occurred" // "Naməlum xəta baş verdi"
        case .emailAlreadyInUse:
            return "This email is already in use" // "Bu email artıq istifadə olunur"
        case .weakPassword:
            return "Password is too weak" // "Şifrə çox zəifdir"
        case .operationNotAllowed:
            return "This operation is not allowed" // "Bu əməliyyata icazə verilmir"
        case .tooManyRequests:
            return "Too many requests. Please try again later" // "Çoxlu sorğu. Zəhmət olmasa daha sonra yenidən cəhd edin"
            
        // Database Errors
        case .documentNotFound:
            return "Document not found" // "Sənəd tapılmadı"
        case .dataCorrupted:
            return "Data is corrupted" // "Məlumat pozulub"
        case .permissionDenied:
            return "Permission denied" // "İcazə rədd edildi"
        case .quotaExceeded:
            return "Quota exceeded" // "Kvota aşılıb"
        case .unauthenticated:
            return "User is not authenticated" // "İstifadəçi autentifikasiya edilməyib"
        case .invalidArgument:
            return "Invalid argument provided" // "Yanlış arqument təqdim edilib"
        }
    }
    
    /**
     ## English
     Logs error messages for debugging and monitoring.
     Stores error information for future analysis.
     
     ## Azərbaycanca
     Debugging və monitorinq üçün xəta mesajlarını qeyd edir.
     Gələcək analiz üçün xəta məlumatlarını saxlayır.
     */
    static func logError(_ error: Error, context: String) {
        print("Error in \(context): \(error.localizedDescription)")
        // TODO: Implement error logging to a service
    }
}
