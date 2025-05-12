//
//  AppSizeUtility.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 05.05.25.
//

// MARK: - Imports
// English: Importing necessary frameworks for file operations
// Azərbaycanca: Fayl əməliyyatları üçün lazımi framework-lərin import edilməsi
import Foundation

// MARK: - AppSizeUtility
// English: Utility class for checking app size and memory usage
// Azərbaycanca: Tətbiq ölçüsü və yaddaş istifadəsini yoxlamaq üçün utility sinifi
class AppSizeUtility {
    // MARK: - Properties
    // English: Shared instance for singleton pattern
    // Azərbaycanca: Singleton pattern üçün paylaşılan instance
    static let shared = AppSizeUtility()
    
    // English: Private initializer for singleton pattern
    // Azərbaycanca: Singleton pattern üçün private initializer
    private init() {}
    
    // MARK: - App Size Methods
    // English: Get the total size of the app bundle
    // Azərbaycanca: Tətbiq paketinin ümumi ölçüsünü alır
    func getAppBundleSize() throws -> UInt64 {
        guard let bundlePath = Bundle.main.bundlePath as String? else {
            throw NSError(domain: "AppSizeUtility", code: 1, userInfo: [NSLocalizedDescriptionKey: "Bundle path not found"])
        }
        
        let fileManager = FileManager.default
        var totalSize: UInt64 = 0
        
        guard let enumerator = fileManager.enumerator(atPath: bundlePath) else {
            throw NSError(domain: "AppSizeUtility", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to enumerate bundle contents"])
        }
        
        while let file = enumerator.nextObject() as? String {
            let filePath = (bundlePath as NSString).appendingPathComponent(file)
            let attributes = try fileManager.attributesOfItem(atPath: filePath)
            if let fileSize = attributes[.size] as? UInt64 {
                totalSize += fileSize
            }
        }
        
        return totalSize
    }
    
    // English: Get the size of documents directory
    // Azərbaycanca: Sənədlər qovluğunun ölçüsünü alır
    func getDocumentsDirectorySize() throws -> UInt64 {
        let fileManager = FileManager.default
        guard let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.path else {
            throw NSError(domain: "AppSizeUtility", code: 3, userInfo: [NSLocalizedDescriptionKey: "Documents directory not found"])
        }
        
        var totalSize: UInt64 = 0
        
        guard let enumerator = fileManager.enumerator(atPath: documentsPath) else {
            throw NSError(domain: "AppSizeUtility", code: 4, userInfo: [NSLocalizedDescriptionKey: "Failed to enumerate documents directory"])
        }
        
        while let file = enumerator.nextObject() as? String {
            let filePath = (documentsPath as NSString).appendingPathComponent(file)
            let attributes = try fileManager.attributesOfItem(atPath: filePath)
            if let fileSize = attributes[.size] as? UInt64 {
                totalSize += fileSize
            }
        }
        
        return totalSize
    }
    
    // MARK: - Formatting Methods
    // English: Format size in bytes to human readable format
    // Azərbaycanca: Bayt ölçüsünü insanın oxuya biləcəyi formata çevirir
    func formatSize(_ size: UInt64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB, .useGB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(size))
    }
    
    // MARK: - Memory Usage Methods
    // English: Get current memory usage
    // Azərbaycanca: Cari yaddaş istifadəsini alır
    func getMemoryUsage() -> UInt64 {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_,
                         task_flavor_t(MACH_TASK_BASIC_INFO),
                         $0,
                         &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            return info.resident_size
        } else {
            return 0
        }
    }
}

// MARK: - Usage Example
/*
// English: Example of how to use AppSizeUtility
// Azərbaycanca: AppSizeUtility-in istifadə nümunəsi

do {
    // Get app bundle size
    let bundleSize = try AppSizeUtility.shared.getAppBundleSize()
    print("Tətbiq ölçüsü: \(AppSizeUtility.shared.formatSize(bundleSize))")
    
    // Get documents directory size
    let documentsSize = try AppSizeUtility.shared.getDocumentsDirectorySize()
    print("Sənədlər qovluğu ölçüsü: \(AppSizeUtility.shared.formatSize(documentsSize))")
    
    // Get memory usage
    let memoryUsage = AppSizeUtility.shared.getMemoryUsage()
    print("Yaddaş istifadəsi: \(AppSizeUtility.shared.formatSize(memoryUsage))")
} catch {
    print("Xəta: \(error.localizedDescription)")
}
*/ 