import Foundation
import UserNotifications
import SwiftUI

// MARK: - PushNotificationManager
// English: Manages push notifications for the app
// Azərbaycanca: Tətbiq üçün push bildirişlərini idarə edir
class PushNotificationManager: NSObject, ObservableObject {
    
    // MARK: - Properties
    // English: Published property to track notification authorization status
    // Azərbaycanca: Bildiriş icazəsi statusunu izləmək üçün published xüsusiyyət
    @Published var isAuthorized = false
    
    // MARK: - Initialization
    // English: Initialize the notification manager
    // Azərbaycanca: Bildiriş menecerini işə salır
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    // MARK: - Methods
    // English: Request notification authorization from user
    // Azərbaycanca: İstifadəçidən bildiriş icazəsi tələb edir
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] granted, error in
            DispatchQueue.main.async {
                self?.isAuthorized = granted
                if granted {
                    print("Notification authorization granted")
                } else if let error = error {
                    print("Notification authorization error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // English: Register for remote notifications
    // Azərbaycanca: Uzaq bildirişlər üçün qeydiyyatdan keçir
    func registerForRemoteNotifications() {
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    // English: Schedule a local notification
    // Azərbaycanca: Yerli bildiriş planlaşdırır
    func scheduleLocalNotification(title: String, body: String, timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate
// English: Extension to handle notification center delegate methods
// Azərbaycanca: Bildiriş mərkəzi delegate metodlarını idarə etmək üçün extension
extension PushNotificationManager: UNUserNotificationCenterDelegate {
    // English: Handle notification when app is in foreground
    // Azərbaycanca: Tətbiq ön planda olduqda bildirişi idarə edir
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    // English: Handle notification when user taps on it
    // Azərbaycanca: İstifadəçi bildirişə tıkladıqda idarə edir
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
} 