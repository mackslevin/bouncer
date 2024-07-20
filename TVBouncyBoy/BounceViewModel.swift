//
//  ContentViewModel.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/11/24.
//

import SwiftUI
import Observation

@Observable
class BounceViewModel {
    var position: CGPoint = CGPoint(x: 100, y: 100)
    var velocity: CGSize = CGSize(width: 4, height: 4)
    var timer: Timer?
    var screenSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    let rectangleSize: CGSize = CGSize(width: 360, height: 220)
    var tighteningAmount: CGFloat = 20
    var shouldTighten = false
    var isShowingOptions = false 
    
    var backgroundImage: AppImage? {
        didSet {
            
            UserDefaults.standard.setValue(backgroundImage?.id.uuidString ?? "", forKey: StorageKeys.currentBackgroundID.rawValue)
        }
    }
    var boxImage: AppImage? {
        didSet {
            print("^^ setting")
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
                        print("^^ added first run bg")
                    }
                }
            }
            for appImage in Utility.boxImagePresets {
                Task {
                    await MainActor.run {
                        DataManager.shared.addAppImage(appImage)
                        print("^^ added first run box image")
                    }
                }
            }
            UserDefaults.standard.setValue(false, forKey: StorageKeys.isFirstRun.rawValue)
        }
        
        
        // Grab most recently set images from UserDefaults
        if let bgID = UserDefaults.standard.value(forKey: StorageKeys.currentBackgroundID.rawValue) as? String, !bgID.isEmpty  {
            print("^^ read \(bgID)")
            Task {
                if let bg = try? await DataManager.shared.allUserImages().first(where: {$0.id.uuidString == bgID}) {
                    print("^^ got from swiftdata \(bg.id.uuidString)")
                    backgroundImage = bg
                }
            }
        } 
        
        if let boxID = UserDefaults.standard.value(forKey: StorageKeys.currentBoxImageID.rawValue) as? String, !boxID.isEmpty {
            print("^^ read \(boxID)")
            Task {
                if let box = try? await DataManager.shared.allUserImages().first(where: {$0.id.uuidString == boxID}) {
                    print("^^ got from swiftdata \(box.id.uuidString)")
                    boxImage = box
                }
            }
        }
    }
    
    
//    static let backgroundImagePresets = [
//        AppImage(presetName: "lake"),
//        AppImage(presetName: "blue-cloth"),
//        AppImage(presetName: "test"),
//        AppImage(presetName: "color-puffs")
//    ]
//    
//    static let boxImagePresets = [
//        AppImage(presetName: "randy"),
//        AppImage(presetName: "used-to-this")
//    ]
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.updatePosition()
        }
    }

    func updatePosition() {
        var newX = position.x + velocity.width
        var newY = position.y + velocity.height
        
        if newX - rectangleSize.width / 2 < 0 || newX + rectangleSize.width / 2 > screenSize.width {
            velocity.width = -velocity.width
        }
        
        if newY - rectangleSize.height / 2 < 0 || newY + rectangleSize.height / 2 > screenSize.height {
            velocity.height = -velocity.height
        }
        
        newX = max(rectangleSize.width / 2, min(newX, screenSize.width - rectangleSize.width / 2))
        newY = max(rectangleSize.height / 2, min(newY, screenSize.height - rectangleSize.height / 2))
        
        withAnimation(.linear(duration: 0.05)) {
            position = CGPoint(x: newX, y: newY)
        }
    }
    
    func applyTightening() {
        guard shouldTighten else { return }
        screenSize.width -= tighteningAmount
        screenSize.height -= tighteningAmount
    }
}

