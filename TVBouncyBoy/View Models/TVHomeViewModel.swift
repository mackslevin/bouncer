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
            self.isShowingOverview = true
            UserDefaults.standard.setValue(false, forKey: StorageKeys.isFirstRun.rawValue)
        }
        
        syncPresets()
        
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
    
    private func syncPresets() {
        Task {
            do {
                let allAppImages = try await DataManager.shared.allUserImages()
                var allPresets = Utility.backgroundImagePresets
                allPresets.append(contentsOf: Utility.boxImagePresets)
                
                for ai in allAppImages.filter({$0.presetName != nil}) {
                    // Remove saved images that are no longer among the current presets
                    if !allPresets.contains(where: {$0.title == ai.title})  {
                        print("^^ Deleting \(ai.title ?? "")")
                        await DataManager.shared.deleteAppImage(ai)
                    }
                    
                    // Delete any duplicates
                    var duplicates = allAppImages.filter({$0.presetName == ai.presetName && $0.imageType == ai.imageType})
                    if duplicates.count > 1 {
                        let otherDups = duplicates.filter({$0.id != ai.id})
                        for dup in otherDups {
                            await DataManager.shared.deleteAppImage(dup)
                        }
                    }
                }
                
                
                // Save any image among the presets which isn't already saved
                for bg in Utility.backgroundImagePresets {
                    if !allAppImages.filter({$0.imageType == .background}).contains(where: {$0.title == bg.title}) {
                        print("^^ Adding \(bg.title ?? "?")")
                        await DataManager.shared.addAppImage(bg)
                    }
                }
                for fg in Utility.boxImagePresets {
                    if !allAppImages.filter({$0.imageType == .boxImage}).contains(where: {$0.title == fg.title}) {
                        print("^^ Adding \(fg.title ?? "?")")
                        await DataManager.shared.addAppImage(fg)
                    }
                }
                
                
            } catch {
                print("^^ Sync presets error")
                print(error.localizedDescription)
            }
        }
    }
    
    
}
