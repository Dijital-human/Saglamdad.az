////
////  FirebaseManager.swift
////  Virtual Human
////
////  Created by Famil Mustafayev on 05.05.25.
////
//
//// MARK: - Imports
//// English: Importing necessary frameworks for Firebase operations
//// Azərbaycanca: Firebase əməliyyatları üçün lazımi framework-lərin import edilməsi
//import Foundation
//import FirebaseFirestore
//
//// MARK: - FirebaseError
//// English: Custom error types for Firebase operations
//// Azərbaycanca: Firebase əməliyyatları üçün xüsusi xəta növləri
//enum FirebaseError: Error {
//    case documentNotFound
//    case invalidData
//    case encodingError
//    case decodingError
//    case networkError
//    case unknownError
//    
//    // English: Error description for user feedback
//    // Azərbaycanca: İstifadəçi geri bildirimi üçün xəta təsviri
//    var description: String {
//        switch self {
//        case .documentNotFound:
//            return "Document not found"
//        case .invalidData:
//            return "Invalid data format"
//        case .encodingError:
//            return "Error encoding data"
//        case .decodingError:
//            return "Error decoding data"
//        case .networkError:
//            return "Network connection error"
//        case .unknownError:
//            return "Unknown error occurred"
//        }
//    }
//}
//
//// MARK: - FirebaseManager
//// English: Universal manager class for handling Firebase operations
//// Azərbaycanca: Firebase əməliyyatlarını idarə edən universal manager sinifi
//class FirebaseManager {
//    // MARK: - Properties
//    // English: Shared instance for singleton pattern
//    // Azərbaycanca: Singleton pattern üçün paylaşılan instance
//    static let shared = FirebaseManager()
//    
//    // English: Firestore database instance
//    // Azərbaycanca: Firestore verilənlər bazası instansı
//    private let db = Firestore.firestore()
//    
//    // English: Private initializer for singleton pattern
//    // Azərbaycanca: Singleton pattern üçün private initializer
//    private init() {}
//    
//    // MARK: - CRUD Operations
//    // MARK: Create
//    // English: Create a new document in a collection
//    // Azərbaycanca: Koleksiyada yeni sənəd yaradır
//    func create<T: Encodable>(
//        _ data: T,
//        in collection: String,
//        documentID: String? = nil
//    ) async throws -> String {
//        do {
//            let docRef: DocumentReference
//            
//            if let documentID = documentID {
//                docRef = db.collection(collection).document(documentID)
//            } else {
//                docRef = db.collection(collection).document()
//            }
//            
//            try docRef.setData(from: data)
//            return docRef.documentID
//        } catch {
//            throw FirebaseError.encodingError
//        }
//    }
//    
//    // MARK: Read
//    // English: Read a document from a collection
//    // Azərbaycanca: Koleksiyadan sənəd oxuyur
//    func read<T: Decodable>(
//        _ type: T.Type,
//        from collection: String,
//        documentID: String
//    ) async throws -> T {
//        do {
//            let docRef = db.collection(collection).document(documentID)
//            let document = try await docRef.getDocument()
//            
//            guard document.exists else {
//                throw FirebaseError.documentNotFound
//            }
//            
//            return try document.data(as: T.self)
//        } catch {
//            if let error = error as? FirebaseError {
//                throw error
//            }
//            throw FirebaseError.decodingError
//        }
//    }
//    
//    // English: Read all documents from a collection
//    // Azərbaycanca: Koleksiyadan bütün sənədləri oxuyur
//    func readAll<T: Decodable>(
//        _ type: T.Type,
//        from collection: String,
//        where field: String? = nil,
//        isEqualTo value: Any? = nil
//    ) async throws -> [T] {
//        do {
//            var query: Query = db.collection(collection)
//            
//            if let field = field, let value = value {
//                query = query.whereField(field, isEqualTo: value)
//            }
//            
//            let snapshot = try await query.getDocuments()
//            return try snapshot.documents.compactMap { try $0.data(as: T.self) }
//        } catch {
//            throw FirebaseError.decodingError
//        }
//    }
//    
//    // MARK: Update
//    // English: Update a document in a collection
//    // Azərbaycanca: Koleksiyada sənədi yeniləyir
//    func update<T: Encodable>(
//        _ data: T,
//        in collection: String,
//        documentID: String
//    ) async throws {
//        do {
//            let docRef = db.collection(collection).document(documentID)
//            try await docRef.setData(from: data, merge: true)
//        } catch {
//            throw FirebaseError.encodingError
//        }
//    }
//    
//    // MARK: Delete
//    // English: Delete a document from a collection
//    // Azərbaycanca: Koleksiyadan sənədi silir
//    func delete(
//        from collection: String,
//        documentID: String
//    ) async throws {
//        do {
//            let docRef = db.collection(collection).document(documentID)
//            try await docRef.delete()
//        } catch {
//            throw FirebaseError.unknownError
//        }
//    }
//    
//    // MARK: - Query Operations
//    // English: Query documents with multiple conditions
//    // Azərbaycanca: Çoxlu şərtlərlə sənədləri sorğulayır
//    func query<T: Decodable>(
//        _ type: T.Type,
//        from collection: String,
//        where conditions: [(field: String, operator: String, value: Any)]
//    ) async throws -> [T] {
//        do {
//            var query: Query = db.collection(collection)
//            
//            for condition in conditions {
//                query = query.whereField(condition.field, isEqualTo: condition.value)
//            }
//            
//            let snapshot = try await query.getDocuments()
//            return try snapshot.documents.compactMap { try $0.data(as: T.self) }
//        } catch {
//            throw FirebaseError.decodingError
//        }
//    }
//    
//    // MARK: - Batch Operations
//    // English: Perform batch write operations
//    // Azərbaycanca: Batch yazma əməliyyatlarını yerinə yetirir
//    func batchWrite<T: Encodable>(
//        operations: [(type: String, data: T, documentID: String?)]
//    ) async throws {
//        do {
//            let batch = db.batch()
//            
//            for operation in operations {
//                let docRef: DocumentReference
//                if let documentID = operation.documentID {
//                    docRef = db.collection(operation.type).document(documentID)
//                } else {
//                    docRef = db.collection(operation.type).document()
//                }
//                
//                try batch.setData(from: operation.data, forDocument: docRef)
//            }
//            
//            try await batch.commit()
//        } catch {
//            throw FirebaseError.encodingError
//        }
//    }
//}
//
//// MARK: - Usage Example
///*
//// English: Example of how to use FirebaseManager
//// Azərbaycanca: FirebaseManager-in istifadə nümunəsi
//
//// Create a document
//let user = User(name: "John", age: 30)
//let documentID = try await FirebaseManager.shared.create(user, in: "users")
//
//// Read a document
//let loadedUser: User = try await FirebaseManager.shared.read(User.self, from: "users", documentID: documentID)
//
//// Read all documents
//let allUsers: [User] = try await FirebaseManager.shared.readAll(User.self, from: "users")
//
//// Update a document
//let updatedUser = User(name: "John Updated", age: 31)
//try await FirebaseManager.shared.update(updatedUser, in: "users", documentID: documentID)
//
//// Delete a document
//try await FirebaseManager.shared.delete(from: "users", documentID: documentID)
//
//// Query documents
//let conditions = [
//    ("age", ">=", 30),
//    ("name", "==", "John")
//]
//let filteredUsers: [User] = try await FirebaseManager.shared.query(User.self, from: "users", where: conditions)
//
//// Batch operations
//let batchOperations = [
//    ("users", User(name: "John", age: 30), nil),
//    ("users", User(name: "Jane", age: 25), nil)
//]
//try await FirebaseManager.shared.batchWrite(operations: batchOperations)
//*/ 
