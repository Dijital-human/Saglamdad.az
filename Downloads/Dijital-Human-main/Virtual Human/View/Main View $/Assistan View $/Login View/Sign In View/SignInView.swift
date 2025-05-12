//
//  SignInView.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 04.05.25.
//

// MARK: - Imports
// English: Importing necessary SwiftUI framework for building the user interface
// Azərbaycanca: İstifadəçi interfeysini qurmaq üçün lazımi SwiftUI framework-ünün import edilməsi
import SwiftUI
/**
 # SignInView
 ## English
 A SwiftUI view component that handles user authentication.
 Contains email and password input fields with secure password toggle.
 Features smooth animations and responsive design.
 Integrates with Firebase for authentication and error handling.
 
 ## Azərbaycanca
 İstifadəçi autentifikasiyasını idarə edən SwiftUI view komponenti.
 Email və şifrə input sahələri ilə təhlükəsiz şifrə göstərmə/gizlətmə funksionallığı var.
 Yumşaq animasiyalar və responsiv dizayn xüsusiyyətlərinə malikdir.
 Firebase ilə inteqrasiya və xəta idarəetməsi təmin edir.
 */
struct SignInView: View {
    // MARK: - Environment Variables
    // English: Environment variable for dynamic type size adaptation
    // Azərbaycanca: Dinamik tip ölçüsü adaptasiyası üçün environment dəyişəni
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    // MARK: - ViewModel
    @StateObject private var viewModel = SignInViewModel()
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: AppConstants.Layout.spacing) {
            // Phone or Email Authentication
            PhoneOrEmailAuth()
            
            // Social Media Login Section
            SocialLoginSection(isAnimating: viewModel.isAnimating)
            
            // Sign In Button Section
            SignInButtonSection(viewModel: viewModel)
        }
        .onAppear {
            viewModel.startAnimation()
        }
    }
}

// MARK: - SocialLoginSection
// English: Social media login buttons section
// Azərbaycanca: Sosial media giriş düymələri bölməsi
private struct SocialLoginSection: View {
    let isAnimating: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: AppConstants.Layout.spacing) {
            Text(LocalizedStrings.Auth.continueWith)
                .font(.custom(AppConstants.Fonts.primary, size: AppConstants.Fonts.bodySize))
                .foregroundColor(AppConstants.Colors.textSecondary)
            
            HStack(alignment: .center, spacing: AppConstants.Layout.spacing) {
                Spacer()
                SocialLoginButton(icon: "apple.logo", text: LocalizedStrings.Social.apple, color: .black, textColor: .white)
                SocialLoginButton(icon: "g.circle.fill", text: LocalizedStrings.Social.google, color: .white, textColor: .black, iconColor: .red)
                SocialLoginButton(icon: "f.circle.fill", text: LocalizedStrings.Social.facebook, color: .blue, textColor: .white)
                SocialLoginButton(icon: "t.circle.fill", text: LocalizedStrings.Social.twitter, color: .blue.opacity(0.8), textColor: .white)
                Spacer()
            }
        }
        .scaleEffect(isAnimating ? 1 : 0.9)
        .opacity(isAnimating ? 1 : 0)
        .animation(AppConstants.Animation.spring.delay(AppConstants.Animation.delay), value: isAnimating)
    }
}

// MARK: - SocialLoginButton
// English: Reusable social media login button
// Azərbaycanca: Yenidən istifadə edilə bilən sosial media giriş düyməsi
private struct SocialLoginButton: View {
    let icon: String
    let text: String
    let color: Color
    let textColor: Color
    var iconColor: Color? = nil
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: AppConstants.Fonts.titleSize))
                    .foregroundColor(iconColor ?? textColor)
                Text(text)
                    .font(.custom(AppConstants.Fonts.primary, size: AppConstants.Fonts.bodySize))
            }
            .foregroundColor(textColor)
            .padding(.horizontal, AppConstants.Layout.padding)
            .padding(.vertical, AppConstants.Layout.spacing)
            .background(
                RoundedRectangle(cornerRadius: AppConstants.Layout.cornerRadius)
                    .fill(color)
            )
        }
        .buttonStyle(.borderless)
    }
}

// MARK: - SignInButtonSection
// English: Sign in and forgot password buttons section
// Azərbaycanca: Giriş və şifrəni unutdum düymələri bölməsi
private struct SignInButtonSection: View {
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        VStack(spacing: AppConstants.Layout.spacing) {
            Button(action: { viewModel.signIn() }) {
                Text(LocalizedStrings.Auth.signIn)
                    .font(.custom(AppConstants.Fonts.primary, size: AppConstants.Fonts.titleSize))
                    .foregroundColor(AppConstants.Colors.textPrimary)
                    .frame(maxWidth: .infinity)
                    .frame(height: AppConstants.Layout.buttonHeight)
            }
            .buttonStyle(.borderless)
            .background(
                RoundedRectangle(cornerRadius: AppConstants.Layout.cornerRadius)
                    .fill(AppConstants.Colors.primary)
            )
            
            Button(action: {}) {
                Text(LocalizedStrings.Auth.forgotPassword)
                    .font(.custom(AppConstants.Fonts.primary, size: AppConstants.Fonts.bodySize))
                    .foregroundColor(AppConstants.Colors.textSecondary)
            }
            .buttonStyle(.borderless)
        }
    }
}

// MARK: - Preview
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .previewLayout(.sizeThatFits)
            .background(AppConstants.Colors.background)
    }
}

#Preview(windowStyle: .automatic) {
    SignInView()
        .frame(width: 800, height: 400)
        .background(Color.black.opacity(0.3))
} 
