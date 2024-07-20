//
//  Utility.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI

struct Utility {
    static func uniqueFilename(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        return dateFormatter.string(from: date)
    }
    
    static let defaultCornerRadius: CGFloat = 5
    
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
}
