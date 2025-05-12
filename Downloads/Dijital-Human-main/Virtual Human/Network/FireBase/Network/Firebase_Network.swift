////
////  Firebase_Network.swift
////  Virtual Human
////
////  Created by Famil Mustafayev on 04.05.25.
////
//
//import SwiftUI
//import Firebase
//import FirebaseAuth
//import FirebaseFirestore
//
///**
// # FirebaseNetwork
// ## English
// Manages all Firebase-related network operations.
// Handles authentication, database operations, and error handling.
// Provides a centralized interface for Firebase services.
// 
// ## Azərbaycanca
// Firebase ilə əlaqəli bütün şəbəkə əməliyyatlarını idarə edir.
// Autentifikasiya, verilənlər bazası əməliyyatları və xəta idarəetməsini həyata keçirir.
// Firebase xidmətləri üçün mərkəzləşdirilmiş interfeys təqdim edir.
// */
//class FirebaseNetwork {
//    static let shared = FirebaseNetwork()
//    private let auth = Auth.auth()
//    private let db = Firestore.firestore()
//    
//    private init() {}
//    
//    /**
//     ## English
//     Signs in a user with email and password.
//     Handles authentication and error cases.
//     
//     ## Azərbaycanca
//     İstifadəçini email və şifrə ilə daxil edir.
//     Autentifikasiya və xəta hallarını idarə edir.
//     */
//    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
//        auth.signIn(withEmail: email, password: password) { result, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            if let user = result?.user {
//                self.updateUserLastLogin(user.uid)
//                completion(.success(user))
//            }
//        }
//    }
//    
//    /**
//     ## English
//     Signs up a new user with email and password.
//     Creates user profile in Firestore.
//     
//     ## Azərbaycanca
//     Yeni istifadəçini email və şifrə ilə qeydiyyatdan keçirir.
//     Firestore-da istifadəçi profili yaradır.
//     */
//    func signUp(email: String, password: String, userData: [String: Any], completion: @escaping (Result<User, Error>) -> Void) {
//        auth.createUser(withEmail: email, password: password) { result, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            if let user = result?.user {
//                self.createUserProfile(userId: user.uid, userData: userData) { error in
//                    if let error = error {
//                        completion(.failure(error))
//                        return
//                    }
//                    completion(.success(user))
//                }
//            }
//        }
//    }
//    
//    /**
//     ## English
//     Signs out the current user.
//     Clears authentication state.
//     
//     ## Azərbaycanca
//     Cari istifadəçini çıxış edir.
//     Autentifikasiya vəziyyətini təmizləyir.
//     */
//    func signOut() throws {
//        try auth.signOut()
//    }
//    
//    /**
//     ## English
//     Updates user's last login timestamp.
//     Tracks user activity in Firestore.
//     
//     ## Azərbaycanca
//     İstifadəçinin son giriş vaxtını yeniləyir.
//     Firestore-da istifadəçi fəaliyyətini izləyir.
//     */
//    private func updateUserLastLogin(_ userId: String) {
//        db.collection("users").document(userId).updateData([
//            "lastLogin": Timestamp(),
//            "loginCount": FieldValue.increment(Int64(1))
//        ]) { error in
//            if let error = error {
//                ErrorManager.logError(error, context: "updateUserLastLogin")
//            }
//        }
//    }
//    
//    /**
//     ## English
//     Creates user profile in Firestore.
//     Stores user information and preferences.
//     
//     ## Azərbaycanca
//     Firestore-da istifadəçi profili yaradır.
//     İstifadəçi məlumatlarını və seçimlərini saxlayır.
//     */
//    private func createUserProfile(userId: String, userData: [String: Any], completion: @escaping (Error?) -> Void) {
//        var profileData = userData
//        profileData["createdAt"] = Timestamp()
//        profileData["updatedAt"] = Timestamp()
//        
//        db.collection("users").document(userId).setData(profileData) { error in
//            completion(error)
//        }
//    }
//    
//    /**
//     ## English
//     Fetches user profile from Firestore.
//     Retrieves user information and preferences.
//     
//     ## Azərbaycanca
//     Firestore-dan istifadəçi profilini gətirir.
//     İstifadəçi məlumatlarını və seçimlərini əldə edir.
//     */
//    func fetchUserProfile(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
//        db.collection("users").document(userId).getDocument { snapshot, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            if let data = snapshot?.data() {
//                completion(.success(data))
//            } else {
//                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User profile not found"])))
//            }
//        }
//    }
//    
//    /**
//     ## English
//     Updates user profile in Firestore.
//     Modifies user information and preferences.
//     
//     ## Azərbaycanca
//     Firestore-da istifadəçi profilini yeniləyir.
//     İstifadəçi məlumatlarını və seçimlərini dəyişdirir.
//     */
//    func updateUserProfile(userId: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
//        var updateData = data
//        updateData["updatedAt"] = Timestamp()
//        
//        db.collection("users").document(userId).updateData(updateData) { error in
//            completion(error)
//        }
//    }
//    
//    /**
//     ## English
//     Sends password reset email.
//     Handles password recovery process.
//     
//     ## Azərbaycanca
//     Şifrə sıfırlama emaili göndərir.
//     Şifrə bərpa prosesini idarə edir.
//     */
//    func sendPasswordReset(email: String, completion: @escaping (Error?) -> Void) {
//        auth.sendPasswordReset(withEmail: email) { error in
//            completion(error)
//        }
//    }
//}
