//
//  TVBouncyBoy_iOSApp.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI
import SwiftData

@main
struct TVBouncyBoy_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(DataManager.shared.container)
    }
}
