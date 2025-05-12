// MARK: - Imports
// English: Importing SwiftUI for UI components
// Azərbaycanca: UI komponentləri üçün SwiftUI-nin import edilməsi
import SwiftUI

// MARK: - PhoneRulesView
// English: View for displaying phone number validation rules and errors
// Azərbaycanca: Telefon nömrəsi yoxlama qaydaları və xətalarını göstərən view
struct PhoneRulesView: View {
    // MARK: - Properties
    // English: Phone number to validate
    // Azərbaycanca: Yoxlanılacaq telefon nömrəsi
    let phone: String
    
    // English: Phone validation rules instance
    // Azərbaycanca: Telefon yoxlama qaydaları instansı
    private let phoneRule = PhoneRule()
    
    // MARK: - Body
    // English: Main view body
    // Azərbaycanca: Əsas view body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // MARK: - Title
            // English: Title section
            // Azərbaycanca: Başlıq bölməsi
            Text("Phone Number Rules")
                .font(.title2)
                .foregroundColor(.white)
                .padding(.bottom, 8)
            
            // MARK: - Rules List
            // English: List of validation rules and their status
            // Azərbaycanca: Yoxlama qaydaları və onların statusu siyahısı
            VStack(alignment: .leading, spacing: 12) {
                let validationResult = phoneRule.validatePhone(phone)
                
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
                        
                        Text("Valid phone number format")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.9))
                    }
                }

                Text("Example Formats:")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 8)
                
                Text("Azerbaijan: +994 50 123 45 67")
                Text("Turkey: +90 532 123 4567")
                Text("Russia: +7 999 123 4567")
                Text("USA/Canada: +1 234 567 8900")
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
    PhoneRulesView(phone: "1234567890")
}
