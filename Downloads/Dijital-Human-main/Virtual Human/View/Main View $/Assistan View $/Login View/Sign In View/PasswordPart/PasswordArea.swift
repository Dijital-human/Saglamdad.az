//
//  PasswordArea.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 05.05.25.
//

// MARK: - Imports
// English: Importing SwiftUI framework for building the user interface
// Azərbaycanca: İstifadəçi interfeysini qurmaq üçün SwiftUI framework-ünün import edilməsi
import SwiftUI

// MARK: - PasswordArea
// English: View for password input with validation and rules display
// Azərbaycanca: Yoxlama və qaydalar göstəricisi ilə şifrə daxilolması üçün view
struct PasswordArea: View {
    // MARK: - State Variables
    // English: State variable for storing password input
    // Azərbaycanca: Şifrə daxilolmasını saxlayan state dəyişəni
    @State private var password = ""
    
    // English: State variable for toggling password visibility
    // Azərbaycanca: Şifrənin görünürlüyünü dəyişdirmək üçün state dəyişəni
    @State private var isPasswordVisible = false
    
    // English: State variable for showing password rules
    // Azərbaycanca: Şifrə qaydalarını göstərmək üçün state dəyişəni
    @State private var showPasswordRules = false
    
    // English: State variable for tracking if password field is focused
    // Azərbaycanca: Şifrə sahəsinin fokusda olub-olmadığını izləyən state dəyişəni
    @FocusState private var isPasswordFocused: Bool
    
    // MARK: - Properties
    // English: Password rules implementation
    // Azərbaycanca: Şifrə qaydalarının implementasiyası
    private let passwordRules = DefaultPasswordRules()
    
    // MARK: - Private Methods
    // English: Validates password and shows rules if needed
    // Azərbaycanca: Şifrəni yoxlayır və lazım olduqda qaydaları göstərir
    private func validatePassword() {
        let result = passwordRules.validatePassword(password)
        if !result.isValid {
            showPasswordRules = true
        }
    }
    
    // MARK: - Body
    // English: Main view body containing password input and rules
    // Azərbaycanca: Şifrə daxilolması və qaydaları ehtiva edən əsas view body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // MARK: - Password Input Field
            // English: Password input field with visibility toggle
            // Azərbaycanca: Görünürlük dəyişdiricisi ilə şifrə daxilolma sahəsi
            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.custom("Georgia", size: 16))
                    .foregroundColor(.white.opacity(0.9))
                
                HStack {
                    VStack {
                        if isPasswordVisible {
                            TextField("", text: $password)
                                .focused($isPasswordFocused)
                                .onChange(of: password) { oldValue, newValue in
                                    if !isPasswordFocused {
                                        validatePassword()
                                    }
                                }
                                .onSubmit {
                                    validatePassword()
                                }
                        } else {
                            SecureField("", text: $password)
                                .focused($isPasswordFocused)
                                .onChange(of: password) { oldValue, newValue in
                                    if !isPasswordFocused {
                                        validatePassword()
                                    }
                                }
                                .onSubmit {
                                    validatePassword()
                                }
                        }
                    }
                    .padding()
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .buttonStyle(.borderless)
                }
                .textFieldStyle(.plain)
                .frame(minHeight: 60)
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
        .sheet(isPresented: $showPasswordRules) {
            // MARK: - Password Rules Modal View
            // English: Modal view for displaying password rules
            // Azərbaycanca: Şifrə qaydalarını göstərmək üçün modal view
            ZStack {
                // MARK: - Background Tap Dismiss
                // English: Dismiss sheet when tapping outside
                // Azərbaycanca: Xaricə toxunulduqda pəncərəni bağla
                Color.black.opacity(0.001)
                    .onTapGesture {
                        showPasswordRules = false
                    }
                
                // MARK: - Password Rules Content
                // English: Password rules content with dismiss button
                // Azərbaycanca: Bağlama düyməsi ilə şifrə qaydaları məzmunu
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: {
                            showPasswordRules = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .buttonStyle(.borderless)
                    }
                    .padding()
                    
                    PasswordRulesView(password: password)
                        .padding(.horizontal)
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black.opacity(0.8))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
                .padding()
            }
            .presentationBackground(.clear)
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
            .frame(width: 400, height: 300)
            // MARK: - Sheet Position
            // English: Position the sheet in the top-left corner of the screen
            // Azərbaycanca: Pəncərəni ekranın sol yuxarı küncündə yerləşdir
            //.position(x: 200, y: 150) // Half of width and height to center the sheet in the top-left quadrant
        }
    }
}

// MARK: - Preview
// English: Preview provider for PasswordArea
// Azərbaycanca: PasswordArea üçün preview provider
#Preview {
    PasswordArea()
        .padding()
        .background(Color.black.opacity(0.3))
}
