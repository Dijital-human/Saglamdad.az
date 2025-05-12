//
//  GlobalNetworkManager.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 05.05.25.
//

// MARK: - Imports
// English: Importing necessary frameworks for network operations
// Azərbaycanca: Şəbəkə əməliyyatları üçün lazımi framework-lərin import edilməsi
import Foundation

// MARK: - GlobalNetworkError
// English: Custom error types for global network operations
// Azərbaycanca: Global şəbəkə əməliyyatları üçün xüsusi xəta növləri
enum GlobalNetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError
    case encodingError
    case networkError
    case unauthorized
    case serverError
    case unknownError
    
    // English: Error description for user feedback
    // Azərbaycanca: İstifadəçi geri bildirimi üçün xəta təsviri
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid server response"
        case .invalidData:
            return "Invalid data received"
        case .decodingError:
            return "Error decoding data"
        case .encodingError:
            return "Error encoding data"
        case .networkError:
            return "Network connection error"
        case .unauthorized:
            return "Unauthorized access"
        case .serverError:
            return "Server error"
        case .unknownError:
            return "Unknown error occurred"
        }
    }
}

// MARK: - HTTPMethod
// English: HTTP request methods
// Azərbaycanca: HTTP sorğu metodları
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// MARK: - GlobalNetworkManager
// English: Manager class for handling global network operations
// Azərbaycanca: Global şəbəkə əməliyyatlarını idarə edən manager sinifi
class GlobalNetworkManager {
    // MARK: - Properties
    // English: Shared instance for singleton pattern
    // Azərbaycanca: Singleton pattern üçün paylaşılan instance
    static let shared = GlobalNetworkManager()
    
    // English: Base URL for API requests
    // Azərbaycanca: API sorğuları üçün əsas URL
    private var baseURL: String = ""
    
    // English: API key for authentication
    // Azərbaycanca: Autentifikasiya üçün API açarı
    private var apiKey: String = ""
    
    // English: Private initializer for singleton pattern
    // Azərbaycanca: Singleton pattern üçün private initializer
    private init() {}
    
    // MARK: - Configuration
    // English: Configure the network manager with base URL and API key
    // Azərbaycanca: Şəbəkə managerini əsas URL və API açarı ilə konfiqurasiya edir
    func configure(baseURL: String, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    // MARK: - Network Operations
    // English: Make a network request
    // Azərbaycanca: Şəbəkə sorğusu göndərir
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {
        // Create URL
        guard let url = URL(string: baseURL + endpoint) else {
            throw GlobalNetworkError.invalidURL
        }
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Add API key to headers
        var requestHeaders = headers ?? [:]
        requestHeaders["Authorization"] = "Bearer \(apiKey)"
        requestHeaders["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = requestHeaders
        
        // Add parameters if needed
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                throw GlobalNetworkError.encodingError
            }
        }
        
        // Make request
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Check response
            guard let httpResponse = response as? HTTPURLResponse else {
                throw GlobalNetworkError.invalidResponse
            }
            
            // Handle response status
            switch httpResponse.statusCode {
            case 200...299:
                // Decode response
                do {
                    let decoder = JSONDecoder()
                    return try decoder.decode(T.self, from: data)
                } catch {
                    throw GlobalNetworkError.decodingError
                }
            case 401:
                throw GlobalNetworkError.unauthorized
            case 500...599:
                throw GlobalNetworkError.serverError
            default:
                throw GlobalNetworkError.unknownError
            }
        } catch {
            if let error = error as? GlobalNetworkError {
                throw error
            }
            throw GlobalNetworkError.networkError
        }
    }
}

// MARK: - Usage Example
/*
// English: Example of how to use GlobalNetworkManager
// Azərbaycanca: GlobalNetworkManager-in istifadə nümunəsi

// Configure manager
GlobalNetworkManager.shared.configure(
    baseURL: "https://api.example.com",
    apiKey: "your-api-key"
)

// Make request
do {
    let response: YourResponseType = try await GlobalNetworkManager.shared.request(
        endpoint: "/endpoint",
        method: .post,
        parameters: ["key": "value"],
        headers: ["Custom-Header": "value"]
    )
    // Handle response
} catch {
    // Handle error
    print(error.localizedDescription)
}
*/ 