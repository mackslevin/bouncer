//
//  DataManager.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/18/24.
//

import Foundation
import SwiftData

actor DataManager {
    let shared = DataManager()
    let container: ModelContainer
    
    init() {
        let sharedModelContainer = {
            let schema = Schema([UserImage.self])
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, groupContainer: .identifier("group.com.johnslevin.TVBouncyBoy"), cloudKitDatabase: .private("iCloud.com.johnslevin.TVBouncyBoy"))
            do {
                return try ModelContainer(for: schema, configurations: [config])
            } catch {
                fatalError(error.localizedDescription)
            }
        }()
        
        self.container = sharedModelContainer
    }
}
