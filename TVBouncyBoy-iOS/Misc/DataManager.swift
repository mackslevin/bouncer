//
//  DataManager.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/18/24.
//

import Foundation
import SwiftData

@MainActor
final class DataManager {
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
        let context = container.mainContext
        let items = try context.fetch(FetchDescriptor<AppImage>())
        return items
    }
    
    func addUserImage(data: Data, type: AppImage.ImageType) {
        let img = AppImage(data: data, imageType: type)
        let context = ModelContext(self.container)
        context.insert(img)
        try? context.save()
    }
    
    func addAppImage(_ ai: AppImage) {
        container.mainContext.insert(ai)
        try? container.mainContext.save()
    }
    
    func deleteAppImage(_ ai: AppImage) {
        container.mainContext.delete(ai)
        do {
//            print("^^ Deleting \(ai.title ?? "?")")
//            try container.mainContext.save()
            let context = ModelContext(self.container)
            context.delete(ai)
            try context.save()
            
            let all = try self.allUserImages()
            print("^^ All \(all.compactMap({$0.title}))")
        } catch {
            print("^^ Error deleting")
            print(error)
        }
    }
}
