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
    let sharedModelContainer = {
        let schema = Schema([UserImage.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, groupContainer: .identifier("group.com.johnslevin.TVBouncyBoy"), cloudKitDatabase: .private("iCloud.com.johnslevin.TVBouncyBoy"))
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError(error.localizedDescription)
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
