//
//  LogoView.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 04.05.25.
//

import SwiftUI

/**
 # LogoView
 ## English
 A SwiftUI view component that displays the application logo and welcome message.
 This view is designed to be used in the login screen to create a welcoming first impression.
 
 ## Azərbaycanca
 Tətbiq loqosunu və xoş gəlmisiniz mesajını göstərən SwiftUI view komponenti.
 Bu view giriş ekranında istifadə olunur və istifadəçiyə xoş gəlmisiniz mesajı verir.
 */
struct LogoView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 10.0) {
                /**
                 ## English
                 Main application title displayed in a custom Georgia font.
                 The large size (48) makes it prominent and easily readable.
                 
                 ## Azərbaycanca
                 Georgia şriftində göstərilən əsas tətbiq başlığı.
                 Böyük ölçü (48) onu daha görünən və oxunaqlı edir.
                 */
                Text("Virtual Teach")
                    .font(.custom("Georgia", size:48))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
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
                 Subtitle text that guides users to register and use the application.
                 Uses the same Georgia font but in a smaller size for better hierarchy.
                 
                 ## Azərbaycanca
                 İstifadəçiləri qeydiyyatdan keçməyə və tətbiqi istifadə etməyə yönləndirən alt başlıq.
                 Eyni Georgia şriftindən istifadə edir, lakin daha kiçik ölçüdə.
                 */
                Text("Qeydiyyatdan kecin ve Virtual Teach tetbiqinin isdifa edin")
                    .font(.custom("Georgia", size: 18))
                    .minimumScaleFactor(0.7)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .foregroundColor(.white.opacity(0.9))
                    .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                    .padding(.horizontal)
                    .scaleEffect(isAnimating ? 1 : 0.9)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(
                        .spring(
                            response: 0.6,
                            dampingFraction: 0.6,
                            blendDuration: 0.5
                        ).delay(0.2),
                        value: isAnimating
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                isAnimating = true
            }
        
    }
}

#Preview(windowStyle: .automatic) {
    LogoView()
        .frame(width: 400, height: 200)
        .background(Color.black.opacity(0.3))
}
