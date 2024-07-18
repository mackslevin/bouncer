//
//  DataManager.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/18/24.
//

import Foundation
import SwiftData

actor DataManager {
    static let shared = DataManager()
    let container: ModelContainer
    
    init() {
        let sharedModelContainer = {
            let schema = Schema([AppImage.self])
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, groupContainer: .identifier("group.com.johnslevin.TVBouncyBoy"), cloudKitDatabase: .private("iCloud.com.johnslevin.TVBouncyBoy"))
            do {
                return try ModelContainer(for: schema, configurations: [config])
            } catch {
                fatalError(error.localizedDescription)
            }
        }()
        
        self.container = sharedModelContainer
    }
    
    func allUserImages() throws -> [AppImage] {
        let context = ModelContext(self.container)
        let items = try context.fetch(FetchDescriptor<AppImage>())
        return items
    }
    
    func addUserImage(data: Data, type: AppImage.ImageType) {
        let img = AppImage(data: data, imageType: type)
        let context = ModelContext(self.container)
        context.insert(img)
        try? context.save()
    }
}
