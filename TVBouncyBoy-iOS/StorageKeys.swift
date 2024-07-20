//
//  StorageKeys.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/20/24.
//

import Foundation

// Keys for values stored in UserDefaults/AppStorage
enum StorageKeys: String {
    case currentBackgroundID = "currentBackgroundID" // type Optional<AppImage.ID>
    case currentBoxImageID = "currentBoxImageID" // type Optional<AppImage.ID>
    case isFirstRun = "isFirstRun" // type Bool
}
