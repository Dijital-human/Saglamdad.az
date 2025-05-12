//
//  NotificationView.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 05.05.25.
//

// MARK: - Imports
// English: Importing necessary SwiftUI framework
// Azərbaycanca: Lazımi SwiftUI framework-ünün import edilməsi
import SwiftUI

// MARK: - NotificationView
// English: View for displaying notifications
// Azərbaycanca: Bildirişləri göstərmək üçün view
struct TransitionTrueEmailPhoneNotificationView: View {
    // MARK: - Properties
    // English: Title of the notification
    // Azərbaycanca: Bildirişin başlığı
    let title: String
    
    // English: Message of the notification
    // Azərbaycanca: Bildirişin mesajı
    let message: String
    
    // English: Binding for controlling sheet presentation
    // Azərbaycanca: Sheet göstərilməsini idarə edən binding
    @Binding var isPresented: Bool
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            // English: Success icon
            // Azərbaycanca: Uğur ikonu
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.green)
            
            // English: Title
            // Azərbaycanca: Başlıq
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // English: Message
            // Azərbaycanca: Mesaj
            Text(message)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
            
            // English: Close button
            // Azərbaycanca: Bağlama düyməsi
            Button(action: {
                isPresented = false
            }) {
                Text("OK")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding(30)
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
}

// MARK: - Preview
#Preview {
    TransitionTrueEmailPhoneNotificationView(
        title: "Test Title",
        message: "Test Message",
        isPresented: .constant(true)
    )
} 
