//
//  TVBouncyBoyApp.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/6/24.
//

import SwiftUI
import SwiftData

@main
struct TVBouncyBoyApp: App {
    let sharedModelContainer = {
        let schema = Schema([AppImage.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, groupContainer: .identifier("group.com.johnslevin.TVBouncyBoy"), cloudKitDatabase: .private("iCloud.com.johnslevin.TVBouncyBoy"))
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError(error.localizedDescription)
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            BounceView()
//                .fontDesign(.rounded)
        }
        .modelContainer(sharedModelContainer)
    }
}
