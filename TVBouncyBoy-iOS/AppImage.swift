//
//  UserImage.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI
import SwiftData

@Model
final class AppImage: Identifiable, Comparable, Hashable, Codable {
    enum ImageType: String, Codable {
        case background, boxImage
    }
    
    let id = UUID()
    let data: Data?
    let presetName: String? // If this exists, the instance is a preset sourced from an asset catalog image which shares its name with this.
    let title: String?
    let dateAdded = Date.now
    let imageType: ImageType? = ImageType.background
    
    
    
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
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id, data, presetName, title, dateAdded, imageType
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        data = try container.decodeIfPresent(Data.self, forKey: .data)
        presetName = try container.decodeIfPresent(String.self, forKey: .presetName)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        dateAdded = try container.decode(Date.self, forKey: .dateAdded)
        imageType = try container.decode(ImageType.self, forKey: .imageType)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(data, forKey: .data)
        try container.encodeIfPresent(presetName, forKey: .presetName)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encode(dateAdded, forKey: .dateAdded)
        try container.encode(imageType, forKey: .imageType)
    }
    
    static func == (lhs: AppImage, rhs: AppImage) -> Bool {
        lhs.id == rhs.id
    }
}
