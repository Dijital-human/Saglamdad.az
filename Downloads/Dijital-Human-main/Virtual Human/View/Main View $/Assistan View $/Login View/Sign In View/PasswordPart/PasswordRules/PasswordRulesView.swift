// MARK: - Imports
// English: Importing SwiftUI framework for building the user interface
// Azərbaycanca: İstifadəçi interfeysini qurmaq üçün SwiftUI framework-ünün import edilməsi
import SwiftUI

// MARK: - PasswordRulesView
// English: View for displaying password rules and validation messages
// Azərbaycanca: Şifrə qaydalarını və yoxlama mesajlarını göstərən view
struct PasswordRulesView: View {
    // MARK: - Properties
    // English: Password rules implementation
    // Azərbaycanca: Şifrə qaydalarının implementasiyası
    private let passwordRules = DefaultPasswordRules()
    
    // English: Current password being validated
    // Azərbaycanca: Yoxlanılan cari şifrə
    let password: String
    
    // MARK: - Body
    // English: Main view body containing password rules and validation messages
    // Azərbaycanca: Şifrə qaydalarını və yoxlama mesajlarını ehtiva edən əsas view body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // MARK: - Password Requirements Title
            // English: Title for password requirements section
            // Azərbaycanca: Şifrə tələbləri bölməsi üçün başlıq
            Text("Password Requirements")
                .font(.custom("Georgia", size: 16))
                .foregroundColor(.white.opacity(0.9))
                .padding(.leading)
                .padding(.top)
            // MARK: - Password Rules List
            // English: List of password requirements
            // Azərbaycanca: Şifrə tələblərinin siyahısı
            VStack(alignment: .leading, spacing: 8) {
                PasswordRuleItem(
                    text: "At least \(passwordRules.minimumLength) characters",
                    isValid: password.count >= passwordRules.minimumLength
                )
                
                PasswordRuleItem(
                    text: "Maximum \(passwordRules.maximumLength) characters",
                    isValid: password.count <= passwordRules.maximumLength
                )
                
                PasswordRuleItem(
                    text: "At least one uppercase letter",
                    isValid: password.contains(where: { $0.isUppercase })
                )
                
                PasswordRuleItem(
                    text: "At least one lowercase letter",
                    isValid: password.contains(where: { $0.isLowercase })
                )
                
                PasswordRuleItem(
                    text: "At least one number",
                    isValid: password.contains(where: { $0.isNumber })
                )
                
                PasswordRuleItem(
                    text: "At least one special character",
                    isValid: password.contains(where: { !$0.isLetter && !$0.isNumber })
                )
            }
            .padding(.horizontal)
            .padding(.bottom)

        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.1))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
        
    }
}

// MARK: - PasswordRuleItem
// English: View for individual password rule item
// Azərbaycanca: Ayrı-ayrı şifrə qaydası elementi üçün view
struct PasswordRuleItem: View {
    // MARK: - Properties
    // English: Text describing the password rule
    // Azərbaycanca: Şifrə qaydasını təsvir edən mətn
    let text: String
    
    // English: Indicates if the rule is satisfied
    // Azərbaycanca: Qaydanın təmin edilib-edilmədiyini göstərir
    let isValid: Bool
    
    // MARK: - Body
    // English: Main view body for password rule item
    // Azərbaycanca: Şifrə qaydası elementi üçün əsas view body
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: isValid ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isValid ? .green : .white.opacity(0.5))
            
            Text(text)
                .font(.custom("Georgia", size: 14))
                .foregroundColor(.white.opacity(0.8))
        }
    }
}

// MARK: - Preview
// English: Preview provider for PasswordRulesView
// Azərbaycanca: PasswordRulesView üçün preview provider
#Preview {
    PasswordRulesView(password: "Test123!")
        .background(Color.black.opacity(0.3))
} 
