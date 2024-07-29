//
//  OptionsRowButtonLabel.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI

struct OptionsRowButtonLabel: View {
    @Bindable var homeVM: TVHomeViewModel
    let image: AppImage
    let imageType: AppImage.ImageType
    
    let labelHeight: CGFloat = 150
    
    var body: some View {
        Rectangle()
            .overlay {
                ZStack {
                    if let imageValue = image.imageValue {
                        imageValue.resizable().scaledToFill()
                    }
                    
                    if isSelected() {
                        Color.black.opacity(0.5)
                        Image(systemName: "checkmark.circle.fill").resizable().scaledToFit()
                            .frame(height: labelHeight * 0.6)
                            .foregroundStyle(.white)
                            .shadow(radius: 4)
                    }
                }
            }
            .clipped()
            .aspectRatio(16/9, contentMode: .fit)
            .frame(height: labelHeight)
    }
    
    
    func isSelected() -> Bool {
        if imageType == .background && homeVM.backgroundMode != .standardBounce {
            return false
        }
        
        if imageType == .boxImage && homeVM.foregroundMode != .standardBounce {
            return false
        }
        
        return homeVM.boxImage == image || homeVM.backgroundImage == image
    }
}

//#Preview {
//    OptionsRowButtonLabel()
//}
