//
////  AppleLogin.swift
////  Virtual Human
////
////  Created by Famil Mustafayev on 05.05.25.
////
//
//import Foundation
//import SwiftUI
//import AuthenticationServices
//import CryptoKit
//
//// MARK: - AppleLoginManager
//// English: Manager class for handling Apple Sign In
//// Azərbaycanca: Apple Sign In-i idarə edən manager sinifi
//class AppleLoginManager: NSObject, ObservableObject {
//    // MARK: - Published Properties
//    // English: Published properties for UI updates
//    // Azərbaycanca: UI yeniləmələri üçün published xüsusiyyətlər
//    @Published var isAuthenticated = false
//    @Published var userProfile: AppleUserProfile?
//    @Published var error: AppleLoginError?
//    
//    // MARK: - Private Properties
//    // English: Private properties for security
//    // Azərbaycanca: Təhlükəsizlik üçün private xüsusiyyətlər
//    private var currentNonce: String?
//    
//    // MARK: - User Profile Structure
//    // English: Structure to hold user profile data
//    // Azərbaycanca: İstifadəçi profil məlumatlarını saxlayan struktur
//    struct AppleUserProfile {
//        let id: String
//        let email: String?
//        let firstName: String?
//        let lastName: String?
//        let fullName: String?
//    }
//    
//    // MARK: - Error Types
//    // English: Custom error types for Apple Sign In
//    // Azərbaycanca: Apple Sign In üçün xüsusi xəta növləri
//    enum AppleLoginError: LocalizedError {
//        case signInFailed
//        case invalidCredential
//        case userCancelled
//        case invalidResponse
//        case networkError
//        case unknown
//        
//        var errorDescription: String? {
//            switch self {
//            case .signInFailed:
//                return "Sign in failed. Please try again."
//            case .invalidCredential:
//                return "Invalid credentials. Please try again."
//            case .userCancelled:
//                return "Sign in was cancelled."
//            case .invalidResponse:
//                return "Invalid response from Apple."
//            case .networkError:
//                return "Network error. Please check your connection."
//            case .unknown:
//                return "An unknown error occurred."
//            }
//        }
//    }
//    
//    // MARK: - Sign In Methods
//    // English: Method to initiate Apple Sign In
//    // Azərbaycanca: Apple Sign In-i başladan metod
//    func signIn() {
//        let nonce = randomNonceString()
//        currentNonce = nonce
//        
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let request = appleIDProvider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//        request.nonce = sha256(nonce)
//        
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
//    }
//    
//    // MARK: - Helper Methods
//    // English: Generate random nonce string
//    // Azərbaycanca: Təsadüfi nonce string yaradan metod
//    private func randomNonceString(length: Int = 32) -> String {
//        precondition(length > 0)
//        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
//        var result = ""
//        var remainingLength = length
//        
//        while remainingLength > 0 {
//            let randoms: [UInt8] = (0 ..< 16).map { _ in
//                var random: UInt8 = 0
//                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
//                if errorCode != errSecSuccess {
//                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
//                }
//                return random
//            }
//            
//            randoms.forEach { random in
//                if remainingLength == 0 {
//                    return
//                }
//                
//                if random < charset.count {
//                    result.append(charset[Int(random)])
//                    remainingLength -= 1
//                }
//            }
//        }
//        
//        return result
//    }
//    
//    // English: Generate SHA256 hash
//    // Azərbaycanca: SHA256 hash yaradan metod
//    private func sha256(_ input: String) -> String {
//        let inputData = Data(input.utf8)
//        let hashedData = SHA256.hash(data: inputData)
//        let hashString = hashedData.compactMap {
//            String(format: "%02x", $0)
//        }.joined()
//        
//        return hashString
//    }
//}
//
//// MARK: - ASAuthorizationControllerDelegate
//// English: Extension for handling authorization delegate methods
//// Azərbaycanca: Authorization delegate metodlarını idarə edən extension
//extension AppleLoginManager: ASAuthorizationControllerDelegate {
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            guard let nonce = currentNonce else {
//                error = .invalidCredential
//                return
//            }
//            
//            guard let appleIDToken = appleIDCredential.identityToken else {
//                error = .invalidCredential
//                return
//            }
//            
//            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//                error = .invalidCredential
//                return
//            }
//            
//            // English: Create user profile from credentials
//            // Azərbaycanca: Credential-lardan istifadəçi profili yaradır
//            let userProfile = AppleUserProfile(
//                id: appleIDCredential.user,
//                email: appleIDCredential.email,
//                firstName: appleIDCredential.fullName?.givenName,
//                lastName: appleIDCredential.fullName?.familyName,
//                fullName: [appleIDCredential.fullName?.givenName, appleIDCredential.fullName?.familyName]
//                    .compactMap { $0 }
//                    .joined(separator: " ")
//            )
//            
//            self.userProfile = userProfile
//            self.isAuthenticated = true
//            self.error = nil
//            
//            // English: Here you would typically send the token to your backend
//            // Azərbaycanca: Burada adətən token-i backend-ə göndərilir
//            // sendTokenToBackend(idTokenString, nonce)
//        }
//    }
//    
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        if let error = error as? ASAuthorizationError {
//            switch error.code {
//            case .canceled:
//                self.error = .userCancelled
//            case .invalidResponse:
//                self.error = .invalidResponse
//            case .notHandled:
//                self.error = .signInFailed
//            case .failed:
//                self.error = .signInFailed
//            case .notInteractive:
//                self.error = .signInFailed
//            @unknown default:
//                self.error = .unknown
//            }
//        } else {
//            self.error = .unknown
//        }
//    }
//}
//
//// MARK: - ASAuthorizationControllerPresentationContextProviding
//// English: Extension for providing presentation context
//// Azərbaycanca: Presentation context təmin edən extension
//extension AppleLoginManager: ASAuthorizationControllerPresentationContextProviding {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return UIApplication.shared.windows.first!
//    }
//}
//
//// MARK: - AppleLoginView
//// English: SwiftUI view for Apple Sign In button
//// Azərbaycanca: Apple Sign In düyməsi üçün SwiftUI view
//struct AppleLoginView: View {
//    @StateObject private var loginManager = AppleLoginManager()
//    
//    var body: some View {
//        VStack {
//            SignInWithAppleButton(
//                onRequest: { request in
//                    request.requestedScopes = [.fullName, .email]
//                },
//                onCompletion: { result in
//                    switch result {
//                    case .success(let authResults):
//                        // Handle successful sign in
//                        print("Authorization successful")
//                    case .failure(let error):
//                        // Handle error
//                        print("Authorization failed: \(error.localizedDescription)")
//                    }
//                }
//            )
//            .signInWithAppleButtonStyle(.white)
//            .frame(height: 50)
//            .padding()
//            
//            if let error = loginManager.error {
//                Text(error.localizedDescription)
//                    .foregroundColor(.red)
//                    .padding()
//            }
//        }
//    }
//}
//
//#Preview {
//    AppleLoginView()
//}
