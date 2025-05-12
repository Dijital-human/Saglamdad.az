import SwiftUI
import Combine

// MARK: - SignInViewModel
// English: ViewModel for handling sign in logic and state management
// Azərbaycanca: Giriş məntiqini və vəziyyət idarəetməsini həyata keçirən ViewModel
final class SignInViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published private(set) var email: String = ""
    @Published private(set) var password: String = ""
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var showError: Bool = false
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var isAnimating: Bool = false
    
    // MARK: - Private Properties
    private let validationService: ValidationServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(validationService: ValidationServiceProtocol = ValidationService()) {
        self.validationService = validationService
    }
    
    // MARK: - Public Methods
    func updateEmail(_ newEmail: String) {
        email = newEmail
        validateEmail()
    }
    
    func updatePassword(_ newPassword: String) {
        password = newPassword
        validatePassword()
    }
    
    func signIn() {
        guard validateInputs() else { return }
        
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.isLoading = false
            // Add your authentication logic here
        }
    }
    
    func startAnimation() {
        isAnimating = true
    }
    
    // MARK: - Private Methods
    private func validateInputs() -> Bool {
        validateEmail()
        validatePassword()
        return !showError
    }
    
    private func validateEmail() {
        if email.isEmpty {
            showError(message: LocalizedStrings.Auth.emailRequired)
            return
        }
        
        if !validationService.isValidEmail(email) {
            showError(message: LocalizedStrings.Auth.invalidEmail)
            return
        }
    }
    
    private func validatePassword() {
        if password.isEmpty {
            showError(message: LocalizedStrings.Auth.passwordRequired)
            return
        }
        
        if !validationService.isValidPassword(password) {
            showError(message: LocalizedStrings.Auth.invalidPassword)
            return
        }
    }
    
    private func showError(message: String) {
        errorMessage = message
        showError = true
    }
} 