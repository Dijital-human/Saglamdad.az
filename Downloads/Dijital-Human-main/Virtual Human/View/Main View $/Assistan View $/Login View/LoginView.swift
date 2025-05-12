//
//  LoginView.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 04.05.25.
//

import SwiftUI

/**
 # LoginView
 ## English
 The main login screen view that combines the logo and authentication components.
 Features a gradient background and toggle between Sign In and Sign Up sections.
 This view serves as the container for all authentication-related UI elements.
 
 ## Azərbaycanca
 Loqo və autentifikasiya komponentlərini birləşdirən əsas giriş ekranı view.
 Gradient arxa fonu və Giriş/Qeydiyyat bölmələri arasında keçid xüsusiyyətlərinə malikdir.
 Bu view bütün autentifikasiya ilə əlaqəli UI elementləri üçün konteyner rolunu oynayır.
 */
struct LoginView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @State private var isAnimating = false
    @State private var isSignUp = false
    
    var body: some View {
            ZStack {
                /**
                 ## English
                 Background gradient that creates a visually appealing atmosphere.
                 Uses blue and purple colors with opacity for a modern look.
                 
                 ## Azərbaycanca
                 Vizual cəlbedici atmosfer yaradan arxa fon gradienti.
                 Müasir görünüş üçün şəffaflıqla göy və bənövşəyi rənglərdən istifadə edir.
                 */
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.8),
                        Color.purple.opacity(0.8)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 5) {
                    /**
                     ## English
                     Logo view component with animation.
                     Scales and fades in when the view appears.
                     
                     ## Azərbaycanca
                     Animasiyalı loqo view komponenti.
                     View görünəndə ölçüsü və şəffaflığı dəyişir.
                     */
                    LogoView()
                        .frame(height: 100)
                        .scaleEffect(isAnimating ? 1 : 0.8)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(
                            .spring(
                                response: 0.6,
                                dampingFraction: 0.6,
                                blendDuration: 0.5
                            ),
                            value: isAnimating
                        )
                    
                    /**
                     ## English
                     Authentication form with animation.
                     Shows either Sign In or Sign Up form based on the selected mode.
                     
                     ## Azərbaycanca
                     Animasiyalı autentifikasiya forması.
                     Seçilmiş rejimə görə Giriş və ya Qeydiyyat formasını göstərir.
                     */
                    
                        
                    SignInView()
                        .frame(width: 900,height: 500)
                            .transition(.opacity.combined(with: .move(edge: .leading)))
                 
                }
                .padding(.horizontal)
            }.scaleEffect(isAnimating ? 1 : 0.9)
            .opacity(isAnimating ? 1 : 0)
            .animation(
                .spring(
                    response: 0.6,
                    dampingFraction: 0.6,
                    blendDuration: 0.5
                ).delay(0.8),
                value: isAnimating
            )

            .onAppear {
                isAnimating = true
            }
        
    }
}

#Preview(windowStyle: .automatic) {
    LoginView()
}
