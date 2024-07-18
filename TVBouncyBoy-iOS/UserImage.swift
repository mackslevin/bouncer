//
//  UserImage.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/18/24.
//

import Foundation
import SwiftData

@Model
final class UserImage: Identifiable {
    let id = UUID()
    let data: Data?
    let title: String?
    let dateAdded = Date.now
    
    init(data: Data?, title: String? = nil) {
        self.data = data
        
        if title == nil {
            self.title = Utility.uniqueFilename(from: Date.now)
        }
    }
}
