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
    let rowHeight: CGFloat = 100
    var selectedImage: AppImage? = nil
    var isShowingImageDetail = false
    var gridRows: [GridItem] = [GridItem(), GridItem()]
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
}
