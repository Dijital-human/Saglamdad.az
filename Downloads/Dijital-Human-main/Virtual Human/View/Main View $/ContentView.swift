//
//  ContentView.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 04.05.25.
//

// MARK: - Imports
// English: Importing necessary frameworks for building the user interface and 3D content
// Azərbaycanca: İstifadəçi interfeysi və 3D məzmunu qurmaq üçün lazımi framework-lərin import edilməsi
import SwiftUI
import RealityKit

// MARK: - ContentView Structure
// English: Main view structure that serves as the root view of the application
// Azərbaycanca: Tətbiqin əsas view strukturu
struct ContentView: View {
    // English: State variable for controlling animation state
    // Azərbaycanca: Animasiya vəziyyətini idarə edən state dəyişəni
    @State private var isAnimating = false
    
    // English: State variables for app size information
    // Azərbaycanca: Tətbiq ölçüsü məlumatları üçün state dəyişənləri
    @State private var bundleSize: String = "Loading..."
    @State private var documentsSize: String = "Loading..."
    @State private var memoryUsage: String = "Loading..."
    @State private var showSizeInfo: Bool = false
    
    // MARK: - Body
    // English: Main view body containing all UI elements
    // Azərbaycanca: Bütün UI elementlərini ehtiva edən əsas view body
    var body: some View {
        VStack {
            // English: Login view for user authentication
            // Azərbaycanca: İstifadəçi autentifikasiyası üçün giriş view-i
            LoginView()

            // MARK: - Immersive View Transition
            // English: Button for transitioning to immersive view (currently commented out)
            // Azərbaycanca: İmmersiv view-ə keçid düyməsi (hazırda şərh edilib)
            //ToggleImmersiveSpaceButton()

            // English: Add app size information button
            // Azərbaycanca: Tətbiq ölçüsü məlumatı düyməsi əlavə et
//                .onAppear {
//                    checkAppSize()
//
//                    print("Tetbiq Tətbiq ölçüsü:\(bundleSize)")
//                    print("Sənədlər qovluğu ölçüsü: \(documentsSize)")
//                    print("Yaddaş istifadəsi: \(memoryUsage))")
//                }
/*
            Button(action: {
                checkAppSize()
                showSizeInfo = true
            }) {
                Text("Check App Size")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .alert("App Size Information", isPresented: $showSizeInfo) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("""
                    Tətbiq ölçüsü: \(bundleSize)
                    Sənədlər qovluğu ölçüsü: \(documentsSize)
                    Yaddaş istifadəsi: \(memoryUsage)
                    """)
            }
 */
        }
 
        // English: Animation trigger on view appearance (currently commented out)
        // Azərbaycanca: View görünəndə animasiya triggeri (hazırda şərh edilib)
//        .onAppear {
//            isAnimating = true
//        }
    }
    
    // English: Function to check app size
    // Azərbaycanca: Tətbiq ölçüsünü yoxlamaq üçün funksiya
    /*private func checkAppSize() {
        do {
            let bundleSizeValue = try AppSizeUtility.shared.getAppBundleSize()
            bundleSize = AppSizeUtility.shared.formatSize(bundleSizeValue)
            
            let documentsSizeValue = try AppSizeUtility.shared.getDocumentsDirectorySize()
            documentsSize = AppSizeUtility.shared.formatSize(documentsSizeValue)
            
            let memoryUsageValue = AppSizeUtility.shared.getMemoryUsage()
            memoryUsage = AppSizeUtility.shared.formatSize(memoryUsageValue)
        } catch {
            bundleSize = "Error"
            documentsSize = "Error"
            memoryUsage = "Error"
            print("Xəta: \(error.localizedDescription)")
        }
    }*/
}

// MARK: - Preview
// English: Preview provider for SwiftUI canvas
// Azərbaycanca: SwiftUI canvas üçün preview provider
#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
