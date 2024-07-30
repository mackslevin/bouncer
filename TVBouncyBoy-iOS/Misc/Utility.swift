//
//  Utility.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI
import MediaPlayer

struct Utility {
    static func uniqueFilename(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        return dateFormatter.string(from: date)
    }
    
    static let defaultCornerRadius: CGFloat = 5
    
    static var boxCornerRadius: CGFloat {
        if let shouldBeRound = UserDefaults.standard.value(forKey: StorageKeys.boxShouldHaveRoundedCorners.rawValue) as? Bool {
            if !shouldBeRound {
                return 0
            }
        }
        return 10
    }
    
    static let backgroundImagePresets = [
        AppImage(presetName: "lake"),
        AppImage(presetName: "blue-cloth"),
        AppImage(presetName: "test"),
        AppImage(presetName: "color-puffs")
    ]

    static let boxImagePresets = [
        AppImage(presetName: "randy", imageType: .boxImage),
        AppImage(presetName: "used-to-this", imageType: .boxImage)
    ]
    
    static func isTV() -> Bool {
        #if os(tvOS)
        return true
        #else
        return UIDevice.current.userInterfaceIdiom == .tv
        #endif
    }
    
    static func nowPlayingHandlePlayPauseButton() {
        let player = MPMusicPlayerController.systemMusicPlayer
        switch player.playbackState {
            case .stopped:
                player.play()
            case .playing:
                player.pause()
            case .paused:
                player.play()
            default:
                print("^^ 🤷‍♂️")
        }
    }
    
    static func simpleFormattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: .now)
    }
    
    static let tvAppOptionsButtonHeight: CGFloat = 150
}
