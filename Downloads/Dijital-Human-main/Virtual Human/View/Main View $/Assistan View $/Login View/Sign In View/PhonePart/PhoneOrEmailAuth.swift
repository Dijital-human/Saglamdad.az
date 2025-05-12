//
//  PhoneCodeCountryParts.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 04.05.25.
//

// MARK: - Imports
// English: Importing necessary SwiftUI framework for building the user interface
// Azərbaycanca: İstifadəçi interfeysini qurmaq üçün lazımi SwiftUI framework-ünün import edilməsi
import SwiftUI

// MARK: - PhoneOrEmailAuth Structure
// English: View structure for handling phone or email authentication
// Azərbaycanca: Telefon və ya email autentifikasiyasını idarə edən view strukturu
struct PhoneOrEmailAuth: View {
    
    // MARK: - State Variables
    // English: State variable for toggling between phone and email authentication
    // Azərbaycanca: Telefon və email autentifikasiyası arasında keçid edən state dəyişəni
    @State private var phoneOremail: Bool = true
    
    // English: State variable for controlling animation
    // Azərbaycanca: Animasiyanı idarə edən state dəyişəni
    @State private var isAnimating = false
    
    // English: State variable for storing phone number input
    // Azərbaycanca: Telefon nömrəsi daxiletməsini saxlayan state dəyişəni
    @State private var phone = ""
    
    // English: State variable for storing email input
    // Azərbaycanca: Email daxiletməsini saxlayan state dəyişəni
    @State private var email = ""
    
    // English: State variable for storing selected country code
    // Azərbaycanca: Seçilmiş ölkə kodunu saxlayan state dəyişəni
    @State private var selectedCountryCode = "+994"
    
    // English: State variable for controlling country picker sheet visibility
    // Azərbaycanca: Ölkə seçimi sheet-inin görünürlüyünü idarə edən state dəyişəni
    @State private var showCountryPicker = false
    
    // English: State variable for storing search text in country picker
    // Azərbaycanca: Ölkə seçimində axtarış mətnini saxlayan state dəyişəni
    @State private var searchText = ""
    
    // English: State variable for controlling phone rules sheet visibility
    // Azərbaycanca: Telefon qaydaları sheet-inin görünürlüyünü idarə edən state dəyişəni
    @State private var showPhoneRules = false
    
    // English: State variable for controlling email rules sheet visibility
    // Azərbaycanca: Email qaydaları sheet-inin görünürlüyünü idarə edən state dəyişəni
    @State private var showEmailRules = false
    
    // English: State variable for controlling phone field focus after validation
    // Azərbaycanca: Validasiyadan sonra telefon sahəsinin fokusunu idarə edən state dəyişəni
    @State private var shouldFocusPhone = false
    
    // English: State variable for controlling email field focus after validation
    // Azərbaycanca: Validasiyadan sonra email sahəsinin fokusunu idarə edən state dəyişəni
    @State private var shouldFocusEmail = false
    
    // English: State variable for tracking if phone field is focused
    // Azərbaycanca: Telefon sahəsinin fokusda olub-olmadığını izləyən state dəyişəni
    @FocusState private var isPhoneFocused: Bool
    
    // English: State variable for tracking if email field is focused
    // Azərbaycanca: Email sahəsinin fokusda olub-olmadığını izləyən state dəyişəni
    @FocusState private var isEmailFocused: Bool
    
    // English: State variable for controlling phone error visibility
    // Azərbaycanca: Telefon xətasının görünürlüyünü idarə edən state dəyişəni
    @State private var showPhoneError = false
    
    // English: State variable for storing phone error message
    // Azərbaycanca: Telefon xətası mətnini saxlayan state dəyişəni
    @State private var phoneError = ""
    
    // English: State variable for controlling email error visibility
    // Azərbaycanca: Email xətasının görünürlüyünü idarə edən state dəyişəni
    @State private var showEmailError = false
    
    // English: State variable for storing email error message
    // Azərbaycanca: Email xətası mətnini saxlayan state dəyişəni
    @State private var emailError = ""
    
    // English: State variable for controlling notification visibility
    // Azərbaycanca: Bildirim görünürlüyünü idarə edən state dəyişəni
    @State private var showNotification = false
    
    // MARK: - Computed Properties
    // English: Computed property for filtering countries based on search text
    // Azərbaycanca: Axtarış mətninə əsasən ölkələri filtrləyən hesablanmış xüsusiyyət
    private var filteredCountries: [CountryCode] {
        if searchText.isEmpty {
            return CountryCodes.all
        } else {
            return CountryCodes.all.filter { country in
                country.name.lowercased().contains(searchText.lowercased()) ||
                country.code.contains(searchText)
            }
        }
    }

    // MARK: - Properties
    // English: Phone validation rules instance
    // Azərbaycanca: Telefon yoxlama qaydaları instansı
    private let phoneRule = PhoneRule()
    
    // English: Email validation rules instance
    // Azərbaycanca: Email yoxlama qaydaları instansı
    private let emailRule = EmailRule()
    
    // MARK: - Private Methods
    // MARK: - Switch Authentication Method
    // English: Function to handle switching between phone and email authentication
    // Azərbaycanca: Telefon və email autentifikasiyası arasında keçidi idarə edən funksiya
    private func switchAuthenticationMethod() {
        // English: Reset all states when switching
        // Azərbaycanca: Keçid zamanı bütün vəziyyətləri sıfırla
        phone = ""
        email = ""
        showPhoneRules = false
        showEmailRules = false
    }

    // MARK: - Validation Methods
    // English: Validate phone number and show appropriate notification
    // Azərbaycanca: Telefon nömrəsini yoxlayır və uyğun bildirişi göstərir
    private func validatePhone() {
        // English: Combine country code and phone number
        // Azərbaycanca: Ölkə kodunu və telefon nömrəsini birləşdirir
        let fullPhone = selectedCountryCode + phone
        
        // English: Check if phone number is empty
        // Azərbaycanca: Telefon nömrəsinin boş olub-olmadığını yoxlayır
        guard !phone.isEmpty else {
            showPhoneRules = true
            return
        }
        
        // English: Check if phone number matches the pattern
        // Azərbaycanca: Telefon nömrəsinin formatla uyğunluğunu yoxlayır
        let phonePattern = "^\\+994[0-9]{9}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phonePattern)
        
        if phonePredicate.evaluate(with: fullPhone) {
            // English: Show success notification if valid
            // Azərbaycanca: Düzgün olduqda uğur bildirişi göstərir
            showNotification = true
        } else {
            // English: Show rules sheet if invalid
            // Azərbaycanca: Yanlış olduqda qaydalar sheet-ini göstərir
            showPhoneRules = true
        }
    }
    
    // English: Validate email and show appropriate notification
    // Azərbaycanca: Email-i yoxlayır və uyğun bildirişi göstərir
    private func validateEmail() {
        // English: Check if email is empty
        // Azərbaycanca: Email-in boş olub-olmadığını yoxlayır
        guard !email.isEmpty else {
            showEmailRules = true
            return
        }
        
        // English: Check if email matches the pattern
        // Azərbaycanca: Email-in formatla uyğunluğunu yoxlayır
        let emailPattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        
        if emailPredicate.evaluate(with: email) {
            // English: Show success notification if valid
            // Azərbaycanca: Düzgün olduqda uğur bildirişi göstərir
            showNotification = true
        } else {
            // English: Show rules sheet if invalid
            // Azərbaycanca: Yanlış olduqda qaydalar sheet-ini göstərir
            showEmailRules = true
        }
    }

    // MARK: - Button Actions
    // English: Handle send code button action
    // Azərbaycanca: Göndər düyməsinin hərəkətini idarə edir
    private func handleSendCode() {
        if phoneOremail {
            validatePhone()
        } else {
            validateEmail()
        }
    }

    // MARK: - Body
    // English: Main view body containing all UI elements
    // Azərbaycanca: Bütün UI elementlərini ehtiva edən əsas view body
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Phone or Email")
                            .font(.custom("Georgia", size:16))
                            .foregroundColor(.white.opacity(0.9))

                        Toggle(isOn: $phoneOremail) {
                            Text(phoneOremail ? "Email" : "Phone")
                        }
                        .toggleStyle(.button)
                        .onChange(of: phoneOremail) { oldValue, newValue in
                            switchAuthenticationMethod()
                        }
                    }
                    HStack(spacing: 5) {
                        //Yoxlayaq ki isdifade ne ile qeydiyyatdan kecmek isdeyir
                        if phoneOremail{
                            /**
                             ## English
                             Country code selection button.
                             Opens a sheet with country selection interface.
                             
                             ## Azərbaycanca
                             Ölkə kodu seçimi düyməsi.
                             Ölkə seçimi interfeysi olan sheet açır.
                             */
                            Button(action: {
                                showCountryPicker = true
                            }) {
                                HStack {
                                    Text(selectedCountryCode)
                                        .foregroundColor(.white)
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white.opacity(0.1))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                            }
                            .buttonStyle(.borderless)
                            
                            /**
                             ## English
                             Phone number input field.
                             Accepts only numeric input with proper formatting.
                             
                             ## Azərbaycanca
                             Telefon nömrəsi input sahəsi.
                             Yalnız rəqəmsal daxilolmaları və düzgün formatlaşdırmalı qəbul edir.
                             */
                            TextField("", text: $phone)
                                .focused($isPhoneFocused)
                                .onChange(of: shouldFocusPhone) { oldValue, newValue in
                                    if newValue {
                                        isPhoneFocused = true
                                        shouldFocusPhone = false
                                    }
                                }
                                .textFieldStyle(.plain)
                                .keyboardType(.phonePad)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white.opacity(0.1))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                                
                                .scaleEffect(isAnimating ? 1 : 0.9)
                                .opacity(isAnimating ? 1 : 0)
                                .animation(
                                    .spring(
                                        response: 0.6,
                                        dampingFraction: 0.6,
                                        blendDuration: 0.5
                                    ).delay(0.8),
                                    value: isAnimating
                                )

                        }
                        else{
                            /**
                             ## English
                             Email address input field.
                             Accepts only numeric input with proper formatting.
                             
                             ## Azərbaycanca
                             Email adres input sahəsi.
                             Yalnız email adresine uygun və düzgün formatlaşdırmalı qəbul edir.
                             */
                            TextField("", text: $email)
                                .focused($isEmailFocused)
                                .onChange(of: shouldFocusEmail) { oldValue, newValue in
                                    if newValue {
                                        isEmailFocused = true
                                        shouldFocusEmail = false
                                    }
                                }
                                .textFieldStyle(.plain)
                                .keyboardType(.emailAddress)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white.opacity(0.1))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                                .scaleEffect(isAnimating ? 1 : 0.9)
                                .opacity(isAnimating ? 1 : 0)
                                .animation(
                                    .spring(
                                        response: 0.6,
                                        dampingFraction: 0.6,
                                        blendDuration: 0.5
                                    ).delay(0.8),
                                    value: isAnimating
                                )

                        }
                        
                        
                        

                        //MARK: Sent Code Phone number or Email adrress
                        Button(action: handleSendCode) {
                            Text("Sent Code")
                                
                                .font(.custom("Georgia", size: 18))
                                .foregroundColor(.white)
                                .frame(maxWidth: 100)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.blue)
                                )
                            }.buttonStyle(.borderless)
                    }
                }
                .frame(minHeight: 80)
                .scaleEffect(isAnimating ? 1 : 0.9)
                .opacity(isAnimating ? 1 : 0)
                .animation(
                    .spring(
                        response: 0.6,
                        dampingFraction: 0.6,
                        blendDuration: 0.5
                    ).delay(0.8),
                    value: isAnimating
                )
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
        }
        .onAppear {
            isAnimating = true
        }
        .sheet(isPresented: $showCountryPicker) {
            /**
             ## English
             Country selection sheet.
             Shows a searchable grid of country flags and codes.
             
             ## Azərbaycanca
             Ölkə seçimi sheet-i.
             Axtarıla bilən ölkə bayraqları və kodları grid-i göstərir.
             */
            VStack(spacing: 20) {
                /**
                 ## English
                 Search bar for country lookup.
                 Updates the grid in real-time as user types.
                 
                 ## Azərbaycanca
                 Ölkə axtarışı üçün axtarış çubuğu.
                 İstifadəçi yazdıqca grid-i real vaxtda yeniləyir.
                 */
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white.opacity(0.7))
                    
                    TextField("Search country...", text: $searchText)
                        .textFieldStyle(.plain)
                        .foregroundColor(.white)
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .buttonStyle(.borderless)
                    }
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
                .padding(.horizontal)
                
                /**
                 ## English
                 Scrollable grid of country flags and codes.
                 Shows 4 countries per row with their flags and codes.
                 
                 ## Azərbaycanca
                 Ölkə bayraqları və kodlarının sürüşdürülə bilən grid-i.
                 Hər sətirdə 4 ölkəni bayraqları və kodları ilə göstərir.
                 */
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 10) {
                        if filteredCountries.isEmpty {
                            Text("No countries found")
                                .foregroundColor(.white.opacity(0.7))
                                .padding()
                                .gridCellColumns(4)
                        } else {
                            ForEach(filteredCountries) { country in
                                Button(action: {
                                    selectedCountryCode = country.code
                                    showCountryPicker = false
                                    searchText = ""
                                }) {
                                    VStack(spacing: 5) {
                                        Text(country.flag)
                                            .font(.system(size: 24))
                                        Text(country.code)
                                            .font(.system(size: 12))
                                            .foregroundColor(.white.opacity(0.8))
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(selectedCountryCode == country.code ?
                                                Color.blue.opacity(0.3) :
                                                Color.white.opacity(0.1))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(selectedCountryCode == country.code ?
                                                Color.blue :
                                                Color.white.opacity(0.2),
                                                lineWidth: 1)
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
            .background(Color.black.opacity(0.3))
        }
        .onAppear {
            isAnimating = true
        }
        .sheet(isPresented: $showPhoneRules) {
            // MARK: - Phone Rules Modal View
            // English: Modal view for displaying phone rules
            // Azərbaycanca: Telefon qaydalarını göstərmək üçün modal view
            ZStack {
                Color.black.opacity(0.001)
                    .onTapGesture {
                        showPhoneRules = false
                    }
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: {
                            showPhoneRules = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .buttonStyle(.borderless)
                    }
                    .padding()
                    
                    PhoneRulesView(phone: phone)
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
            .frame(width: 400, height: 550)
        }
        .sheet(isPresented: $showEmailRules) {
            // MARK: - Email Rules Modal View
            // English: Modal view for displaying email rules
            // Azərbaycanca: Email qaydalarını göstərmək üçün modal view
            ZStack {
                Color.black.opacity(0.001)
                    .onTapGesture {
                        showEmailRules = false
                    }
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: {
                            showEmailRules = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .buttonStyle(.borderless)
                    }
                    .padding()
                    
                    EmailRulesView(email: email)
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
            .frame(width: 400, height: 550)
        }
        .sheet(isPresented: $showNotification) {
            TransitionTrueEmailPhoneNotificationView(
                title: phoneOremail ? "Telefon nömrəsi doğrulandı" : "Email doğrulandı",
                message: phoneOremail ? "Telefon nömrəniz doğrulandı" : "Email adresiniz doğrulandı",
                isPresented: $showNotification
            )
        }
    }
}
    

#Preview(windowStyle: .automatic) {
    PhoneOrEmailAuth()
}
