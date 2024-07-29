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
    
    var backgroundMode: BackgroundMode = .nowPlaying3
    
    var foregroundMode: ForegroundMode = .clock1
    
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
        print("^^ Initializing tv home view model")
        
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
        
        Task {
            try? await setImages()
        }
    }
    
    private func setImages() async throws {
        guard let allImages = try? await DataManager.shared.allUserImages() else {
            print("^^ Couldn't fetch all images")
            return
        }
        
        let savedBackgroundID = UserDefaults.standard.value(forKey: StorageKeys.currentBackgroundID.rawValue) as? String
        if let savedBackgroundID, let bgImage = allImages.first(where: {$0.id.uuidString == savedBackgroundID}) {
            self.backgroundImage = bgImage
        } else if let firstImage = allImages.first(where: {$0.imageType == .background}) {
            self.backgroundImage = firstImage
        }
        
        if let savedBoxID = UserDefaults.standard.value(forKey: StorageKeys.currentBoxImageID.rawValue) as? String, let boxImg = allImages.first(where: {$0.id.uuidString == savedBoxID}) {
            self.boxImage = boxImg
        } else if let firstImage = allImages.first(where: {$0.imageType == .boxImage}) {
            self.boxImage = firstImage
        }
    }
    
    
}
