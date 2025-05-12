//
//  ToggleImmersiveSpaceButton.swift
//  Virtual Human
//
//  Created by Famil Mustafayev on 04.05.25.
//

// MARK: - Imports
// English: Importing SwiftUI framework for building the user interface
// Azərbaycanca: İstifadəçi interfeysini qurmaq üçün SwiftUI framework-ünün import edilməsi
import SwiftUI

// MARK: - ToggleImmersiveSpaceButton Structure
// English: View structure for toggling immersive space
// Azərbaycanca: İmmersiv məkanı açıb-bağlamaq üçün view strukturu
struct ToggleImmersiveSpaceButton: View {
    // MARK: - Environment Variables
    // English: Environment variable for accessing app model
    // Azərbaycanca: App model-ə çıxış üçün environment dəyişəni
    @Environment(AppModel.self) private var appModel

    // English: Environment variable for dismissing immersive space
    // Azərbaycanca: İmmersiv məkanı bağlamaq üçün environment dəyişəni
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    // English: Environment variable for opening immersive space
    // Azərbaycanca: İmmersiv məkanı açmaq üçün environment dəyişəni
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace

    // MARK: - Body
    // English: Main view body containing the toggle button
    // Azərbaycanca: Toggle düyməsini ehtiva edən əsas view body
    var body: some View {
        Button {
            Task { @MainActor in
                switch appModel.immersiveSpaceState {
                    case .open:
                        // English: Handle immersive space closing
                        // Azərbaycanca: İmmersiv məkanın bağlanmasını idarə et
                        appModel.immersiveSpaceState = .inTransition
                        await dismissImmersiveSpace()
                        // English: Don't set immersiveSpaceState to .closed because there
                        // are multiple paths to ImmersiveView.onDisappear().
                        // Only set .closed in ImmersiveView.onDisappear().
                        // Azərbaycanca: immersiveSpaceState-i .closed olaraq təyin etməyin, çünki
                        // ImmersiveView.onDisappear()-ə çoxlu yollar var.
                        // Yalnız ImmersiveView.onDisappear()-də .closed olaraq təyin edin.

                    case .closed:
                        // English: Handle immersive space opening
                        // Azərbaycanca: İmmersiv məkanın açılmasını idarə et
                        appModel.immersiveSpaceState = .inTransition
                        switch await openImmersiveSpace(id: appModel.immersiveSpaceID) {
                            case .opened:
                                // English: Don't set immersiveSpaceState to .open because there
                                // may be multiple paths to ImmersiveView.onAppear().
                                // Only set .open in ImmersiveView.onAppear().
                                // Azərbaycanca: immersiveSpaceState-i .open olaraq təyin etməyin, çünki
                                // ImmersiveView.onAppear()-ə çoxlu yollar ola bilər.
                                // Yalnız ImmersiveView.onAppear()-də .open olaraq təyin edin.
                                break

                            case .userCancelled, .error:
                                // English: On error, we need to mark the immersive space
                                // as closed because it failed to open.
                                // Azərbaycanca: Xəta baş verdikdə, immersiv məkanı bağlı olaraq
                                // işarələməliyik, çünki açıla bilmədi.
                                fallthrough
                            @unknown default:
                                // English: On unknown response, assume space did not open.
                                // Azərbaycanca: Naməlum cavab olduqda, məkanın açılmadığını fərz et.
                                appModel.immersiveSpaceState = .closed
                        }

                    case .inTransition:
                        // English: This case should not ever happen because button is disabled for this case.
                        // Azərbaycanca: Bu hal heç vaxt baş verməməlidir, çünki düymə bu hal üçün deaktivdir.
                        break
                }
            }
        } label: {
            // English: Button label changes based on immersive space state
            // Azərbaycanca: Düymə etiketi immersiv məkanın vəziyyətinə görə dəyişir
            Text(appModel.immersiveSpaceState == .open ? "Hide Immersive Space" : "Show Immersive Space")
        }
        // English: Disable button during transition
        // Azərbaycanca: Keçid zamanı düyməni deaktiv et
        .disabled(appModel.immersiveSpaceState == .inTransition)
        .animation(.none, value: 0)
        .fontWeight(.semibold)
    }
}
