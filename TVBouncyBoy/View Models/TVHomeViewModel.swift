//
//  TVHomeViewModel.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/26/24.
//

import SwiftUI
import Observation

@Observable
final class TVHomeViewModel {
    var isShowingOptions = false
    var isShowingOverview = false
    
    var backgroundMode: BackgroundMode = .standardBounce {
        didSet {
            UserDefaults.standard.setValue(backgroundMode.rawValue, forKey: StorageKeys.backgroundMode.rawValue)
        }
    }
    var foregroundMode: ForegroundMode = .standardBounce {
        didSet {
            UserDefaults.standard.setValue(foregroundMode.rawValue, forKey: StorageKeys.foregroundMode.rawValue)
        }
    }
    
    var backgroundImage: AppImage? {
        didSet {
            UserDefaults.standard.setValue(backgroundImage?.id.uuidString ?? "", forKey: StorageKeys.currentBackgroundID.rawValue)
        }
    }
    var boxImage: AppImage? {
        didSet {
            UserDefaults.standard.setValue(boxImage?.id.uuidString ?? "", forKey: StorageKeys.currentBoxImageID.rawValue)
        }
    }
    
    init() {
        // Add presets to data model on first run
        let isFirstRun = UserDefaults.standard.value(forKey: StorageKeys.isFirstRun.rawValue) as? Bool
        if isFirstRun != false {
            for appImage in Utility.backgroundImagePresets {
                Task {
                    await MainActor.run {
                        DataManager.shared.addAppImage(appImage)
                    }
                }
            }
            for appImage in Utility.boxImagePresets {
                Task {
                    await MainActor.run {
                        DataManager.shared.addAppImage(appImage)
                    }
                }
            }
            
            self.isShowingOverview = true
            
            UserDefaults.standard.setValue(false, forKey: StorageKeys.isFirstRun.rawValue)
        }
        
        if let storedBackgroundMode: String = UserDefaults.standard.string(forKey: StorageKeys.backgroundMode.rawValue) {
            for bgMode in BackgroundMode.allCases {
                if bgMode.rawValue == storedBackgroundMode {
                    self.backgroundMode = bgMode
                }
            }
        }
        
        if let storedForegroundMode = UserDefaults.standard.string(forKey: StorageKeys.foregroundMode.rawValue) {
            for fgMode in ForegroundMode.allCases {
                if fgMode.rawValue == storedForegroundMode {
                    foregroundMode = fgMode
                }
            }
        }
        
        Task {
            try? await setImages()
        }
    }
    
    private func setImages() async throws {
        guard let allImages = try? await DataManager.shared.allUserImages() else {
            print("^^ Couldn't fetch all images")
            return
        }
        
        if backgroundMode == .standardBounce {
            let savedBackgroundID = UserDefaults.standard.value(forKey: StorageKeys.currentBackgroundID.rawValue) as? String
            if let savedBackgroundID, let bgImage = allImages.first(where: {$0.id.uuidString == savedBackgroundID}) {
                self.backgroundImage = bgImage
            } else if let firstImage = allImages.first(where: {$0.imageType == .background}) {
                self.backgroundImage = firstImage
            }
        }
        
        if foregroundMode == .standardBounce {
            if let savedBoxID = UserDefaults.standard.value(forKey: StorageKeys.currentBoxImageID.rawValue) as? String, let boxImg = allImages.first(where: {$0.id.uuidString == savedBoxID}) {
                self.boxImage = boxImg
            } else if let firstImage = allImages.first(where: {$0.imageType == .boxImage}) {
                self.boxImage = firstImage
            }
        }
    }
    
    
}
