//
//  StorageKeys.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/20/24.
//

import Foundation

// Keys for values stored in UserDefaults/AppStorage
enum StorageKeys: String, CaseIterable {
    case currentBackgroundID = "currentBackgroundID" // type Optional<AppImage.ID>
    case currentBoxImageID = "currentBoxImageID" // type Optional<AppImage.ID>
    case isFirstRun = "isFirstRun" // type Bool
    case backgroundMode = "backgroundMode"
    case foregroundMode = "foregroundMode"
    
    // User-settable settings
    case warnBeforeDelete = "warnBeforeDelete"
    case boxShouldHaveRoundedCorners = "boxShouldHaveRoundedCorners"
    case dimBackground = "dimBackground"
    case boxShouldHaveShadow = "boxShouldHaveShadow"
}
