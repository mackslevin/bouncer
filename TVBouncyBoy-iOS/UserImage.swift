//
//  UserImage.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/18/24.
//

import Foundation
import SwiftData

@Model
final class UserImage: Identifiable, Comparable {
    let id = UUID()
    let data: Data?
    let title: String?
    let dateAdded = Date.now
    var imageType = ImageType.background
    
    enum ImageType: Codable {
        case background, boxImage
    }
    
    init(data: Data?, title: String? = nil, imageType: ImageType = .background) {
        self.data = data
        self.title = title
        self.imageType = imageType
        
        if title == nil {
            self.title = Utility.uniqueFilename(from: Date.now)
        }
    }
    
    static func < (lhs: UserImage, rhs: UserImage) -> Bool {
        lhs.dateAdded < rhs.dateAdded
    }
}
