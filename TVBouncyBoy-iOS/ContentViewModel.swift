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
    var selectedImageID: AppImage.ID? = nil
    
    func toggleSelected(id: AppImage.ID?) {
        withAnimation {
            guard let id else { selectedImageID = nil; return }
            
            if selectedImageID == id {
                selectedImageID = nil
            } else {
                selectedImageID = id
            }
        }
    }
}
