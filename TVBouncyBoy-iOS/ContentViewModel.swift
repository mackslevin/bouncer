//
//  ContentViewModel.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI
import Observation
import PhotosUI

@Observable
final class ContentViewModel {
    let rowHeight: CGFloat = 96
    var selectedImage: AppImage? = nil
    var isShowingImageDetail = false
//    var gridRows: [GridItem] = [GridItem(), GridItem()]
    var isShowingSettings = false
    
    func toggleSelected(_ ai: AppImage?) {
        withAnimation {
            guard let ai else { selectedImage = nil; return }
            
            if selectedImage == ai {
                selectedImage = nil
            } else {
                selectedImage = ai
            }
        }
    }
    
    func dynamicGridRows(appImages: [AppImage], type: AppImage.ImageType) -> [GridItem] {
        let userImages = appImages.filter({$0.presetName == nil && $0.imageType == type})
        return userImages.count > 1 ? [GridItem(), GridItem()] : [GridItem()]
    }
}
