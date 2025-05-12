//import SwiftUI
//import GoogleSignIn
//import GoogleSignInSwift
//
//// MARK: - GoogleLoginManager
//// English: Manager class for handling Google Sign In
//// Azərbaycanca: Google Sign In-i idarə edən manager sinifi
//class GoogleLoginManager: ObservableObject {
//    // MARK: - Published Properties
//    // English: Published properties for UI updates
//    // Azərbaycanca: UI yeniləmələri üçün published xüsusiyyətlər
//    @Published var isAuthenticated = false
//    @Published var userProfile: GoogleUserProfile?
//    @Published var error: GoogleLoginError?
//    
//    // MARK: - User Profile Structure
//    // English: Structure to hold user profile data
//    // Azərbaycanca: İstifadəçi profil məlumatlarını saxlayan struktur
//    struct GoogleUserProfile {
//        let id: String
//        let email: String?
//        let name: String?
//        let givenName: String?
//        let familyName: String?
//        let profilePicture: URL?
//    }
//    
//    // MARK: - Error Types
//    // English: Custom error types for Google Sign In
//    // Azərbaycanca: Google Sign In üçün xüsusi xəta növləri
//    enum GoogleLoginError: LocalizedError {
//        case signInFailed
//        case cancelled
//        case invalidConfiguration
//        case networkError
//        case unknown
//        
//        var errorDescription: String? {
//            switch self {
//            case .signInFailed:
//                return "Google sign in failed. Please try again."
//            case .cancelled:
//                return "Google sign in was cancelled."
//            case .invalidConfiguration:
//                return "Invalid Google configuration."
//            case .networkError:
//                return "Network error. Please check your connection."
//            case .unknown:
//                return "An unknown error occurred."
//            }
//        }
//    }
//    
//    // MARK: - Sign In Methods
//    // English: Method to initiate Google Sign In
//    // Azərbaycanca: Google Sign In-i başladan metod
//    func signIn() {
//        guard let clientID = Bundle.main.object(forInfoDictionaryKey: "GIDClientID") as? String else {
//            error = .invalidConfiguration
//            return
//        }
//        
//        let config = GIDConfiguration(clientID: clientID)
//        
//        // English: Check if user is already signed in
//        // Azərbaycanca: İstifadəçinin artıq daxil olub-olmadığını yoxlayır
//        if let user = GIDSignIn.sharedInstance.currentUser {
//            fetchUserProfile(user: user)
//            return
//        }
//        
//        // English: Start sign in process
//        // Azərbaycanca: Daxil olma prosesini başladır
//        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) { [weak self] user, error in
//            if let error = error {
//                if (error as NSError).code == GIDSignInError.canceled.rawValue {
//                    self?.error = .cancelled
//                } else {
//                    print("Google sign in error: \(error.localizedDescription)")
//                    self?.error = .signInFailed
//                }
//                return
//            }
//            
//            guard let user = user else {
//                self?.error = .unknown
//                return
//            }
//            
//            self?.fetchUserProfile(user: user)
//        }
//    }
//    
//    // MARK: - Profile Fetching
//    // English: Method to fetch user profile data
//    // Azərbaycanca: İstifadəçi profil məlumatlarını əldə edən metod
//    private func fetchUserProfile(user: GIDGoogleUser) {
//        let profile = GoogleUserProfile(
//            id: user.userID ?? "",
//            email: user.profile?.email,
//            name: user.profile?.name,
//            givenName: user.profile?.givenName,
//            familyName: user.profile?.familyName,
//            profilePicture: user.profile?.imageURL(withDimension: 200)
//        )
//        
//        DispatchQueue.main.async {
//            self.userProfile = profile
//            self.isAuthenticated = true
//            self.error = nil
//        }
//    }
//    
//    // MARK: - Helper Methods
//    // English: Get root view controller for presenting Google Sign In
//    // Azərbaycanca: Google Sign In-i göstərmək üçün root view controller-i əldə edən metod
//    private func getRootViewController() -> UIViewController {
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let rootViewController = windowScene.windows.first?.rootViewController else {
//            fatalError("No root view controller found")
//        }
//        return rootViewController
//    }
//    
//    // MARK: - Logout Method
//    // English: Method to sign out from Google
//    // Azərbaycanca: Google-dan çıxış edən metod
//    func signOut() {
//        GIDSignIn.sharedInstance.signOut()
//        
//        DispatchQueue.main.async {
//            self.isAuthenticated = false
//            self.userProfile = nil
//        }
//    }
//}
//
//// MARK: - GoogleLoginView
//// English: SwiftUI view for Google Sign In button
//// Azərbaycanca: Google Sign In düyməsi üçün SwiftUI view
//struct GoogleLoginView: View {
//    @StateObject private var loginManager = GoogleLoginManager()
//    
//    var body: some View {
//        VStack {
//            GoogleSignInButton(action: {
//                loginManager.signIn()
//            })
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
//    GoogleLoginView()
//} 
