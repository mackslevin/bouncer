//
//  UserImage.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI
import SwiftData

@Model
final class AppImage: Identifiable, Comparable {
    let id = UUID()
    let data: Data?
    let presetName: String? // If this exists, the instance is a preset sourced from an asset catalog image which shares its name with this.
    let title: String?
    let dateAdded = Date.now
    let imageType = ImageType.background
    
    enum ImageType: Codable {
        case background, boxImage
    }
    
    var imageValue: Image? {
        if let presetName {
            return Image(presetName)
        } else if let data, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        
        return nil
    }
    
    init(data: Data?, title: String? = nil, imageType: ImageType = .background) {
        self.data = data
        self.title = title
        self.imageType = imageType
        
        if title == nil {
            self.title = Utility.uniqueFilename(from: Date.now)
        }
    }
    
    init(presetName: String, imageType: ImageType = .background) {
        self.presetName = presetName
        self.data = nil
        self.title = presetName
        self.imageType = imageType
    }
    
    static func < (lhs: AppImage, rhs: AppImage) -> Bool {
        lhs.dateAdded < rhs.dateAdded
    }
}
