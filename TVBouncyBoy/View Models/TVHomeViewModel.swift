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
    var mode: ViewingMode = .standardBounce
    
    var position: CGPoint = CGPoint(x: 100, y: 100)
    var velocity: CGSize = CGSize(width: 4, height: 4)
    var timer: Timer?
    var screenSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    let rectangleSize: CGSize = CGSize(width: 390, height: 220)
    var tighteningAmount: CGFloat = 20
    var shouldTighten = false
    var isShowingOptions = false
    var isShowingOverview = false
    
    var isLoading = true // This is set to false when BounceView's box image overlay loads
    
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
