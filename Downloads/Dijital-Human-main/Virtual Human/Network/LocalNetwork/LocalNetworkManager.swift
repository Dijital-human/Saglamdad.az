//
//  LocalNetworkManager.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 05.05.25.
//

// MARK: - Imports
// English: Importing necessary frameworks for network operations
// Azərbaycanca: Şəbəkə əməliyyatları üçün lazımi framework-lərin import edilməsi
import Foundation

// MARK: - LocalNetworkError
// English: Custom error types for local network operations
// Azərbaycanca: Lokal şəbəkə əməliyyatları üçün xüsusi xəta növləri
enum LocalNetworkError: Error {
    case fileNotFound
    case invalidData
    case decodingError
    case encodingError
    case fileAccessDenied
    case unknownError
    
    // English: Error description for user feedback
    // Azərbaycanca: İstifadəçi geri bildirimi üçün xəta təsviri
    var description: String {
        switch self {
        case .fileNotFound:
            return "File not found"
        case .invalidData:
            return "Invalid data format"
        case .decodingError:
            return "Error decoding data"
        case .encodingError:
            return "Error encoding data"
        case .fileAccessDenied:
            return "File access denied"
        case .unknownError:
            return "Unknown error occurred"
        }
    }
}

// MARK: - LocalNetworkManager
// English: Manager class for handling local network operations
// Azərbaycanca: Lokal şəbəkə əməliyyatlarını idarə edən manager sinifi
class LocalNetworkManager {
    // MARK: - Properties
    // English: Shared instance for singleton pattern
    // Azərbaycanca: Singleton pattern üçün paylaşılan instance
    static let shared = LocalNetworkManager()
    
    // English: Private initializer for singleton pattern
    // Azərbaycanca: Singleton pattern üçün private initializer
    private init() {}
    
    // MARK: - File Operations
    // English: Save data to a local file
    // Azərbaycanca: Məlumatı lokal fayla yadda saxlayır
    func saveToFile<T: Encodable>(_ data: T, fileName: String) throws {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(data)
            
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                throw LocalNetworkError.fileAccessDenied
            }
            
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            try jsonData.write(to: fileURL)
        } catch {
            throw LocalNetworkError.encodingError
        }
    }
    
    // English: Load data from a local file
    // Azərbaycanca: Məlumatı lokal fayldan yükləyir
    func loadFromFile<T: Decodable>(fileName: String) throws -> T {
        do {
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                throw LocalNetworkError.fileAccessDenied
            }
            
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            let jsonData = try Data(contentsOf: fileURL)
            
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: jsonData)
        } catch {
            if let error = error as? LocalNetworkError {
                throw error
            }
            throw LocalNetworkError.decodingError
        }
    }
    
    // English: Check if file exists
    // Azərbaycanca: Faylın mövcudluğunu yoxlayır
    func fileExists(fileName: String) -> Bool {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return false
        }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    // English: Delete a local file
    // Azərbaycanca: Lokal faylı silir
    func deleteFile(fileName: String) throws {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw LocalNetworkError.fileAccessDenied
        }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        try FileManager.default.removeItem(at: fileURL)
    }
}

// MARK: - Usage Example
/*
// English: Example of how to use LocalNetworkManager
// Azərbaycanca: LocalNetworkManager-in istifadə nümunəsi

// Save data
let data = ["key": "value"]
try LocalNetworkManager.shared.saveToFile(data, fileName: "data.json")

// Load data
let loadedData: [String: String] = try LocalNetworkManager.shared.loadFromFile(fileName: "data.json")

// Check if file exists
let exists = LocalNetworkManager.shared.fileExists(fileName: "data.json")

// Delete file
try LocalNetworkManager.shared.deleteFile(fileName: "data.json")
*/ 