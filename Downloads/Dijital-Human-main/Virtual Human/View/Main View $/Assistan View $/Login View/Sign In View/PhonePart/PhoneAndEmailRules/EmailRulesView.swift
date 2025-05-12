// MARK: - Imports
// English: Importing SwiftUI for UI components
// Azərbaycanca: UI komponentləri üçün SwiftUI-nin import edilməsi
import SwiftUI

// MARK: - EmailRulesView
// English: View for displaying email validation rules and errors
// Azərbaycanca: Email yoxlama qaydaları və xətalarını göstərən view
struct EmailRulesView: View {
    // MARK: - Properties
    // English: Email to validate
    // Azərbaycanca: Yoxlanılacaq email
    let email: String
    
    // English: Email validation rules instance
    // Azərbaycanca: Email yoxlama qaydaları instansı
    private let emailRule = EmailRule()
    
    // MARK: - Body
    // English: Main view body
    // Azərbaycanca: Əsas view body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // MARK: - Title
            // English: Title section
            // Azərbaycanca: Başlıq bölməsi
            Text("Email Rules")
                .font(.title2)
                .foregroundColor(.white)
                .padding(.bottom, 8)
            
            // MARK: - Rules List
            // English: List of validation rules and their status
            // Azərbaycanca: Yoxlama qaydaları və onların statusu siyahısı
            VStack(alignment: .leading, spacing: 12) {
                let validationResult = emailRule.validateEmail(email)
                
                if !validationResult.isValid {
                    ForEach(validationResult.errorMessages, id: \.self) { message in
                        HStack(spacing: 8) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                            
                            Text(message)
                                .font(.system(size: 14))
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }
                } else {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        
                        Text("Valid email format")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.9))
                    }
                }
           
                Text("Example Format:")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 8)
                
                Text("username@domain.com")
                Text("name.surname@company.domain.com")
                Text("user123@subdomain.domain.com")
            }
            .font(.system(size: 14))
            .foregroundColor(.white.opacity(0.7))
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
            )
        }
        .padding()
    }
} 
#Preview(windowStyle: .automatic) {
    EmailRulesView(email: "example")
}
