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
    
    func allUserImages() throws -> [UserImage] {
        let context = ModelContext(self.container)
        let items = try context.fetch(FetchDescriptor<UserImage>())
        return items
    }
    
    func addUserImage(data: Data, type: UserImage.ImageType) {
        let img = UserImage(data: data, imageType: type)
        let context = ModelContext(self.container)
        context.insert(img)
        try? context.save()
    }
}
