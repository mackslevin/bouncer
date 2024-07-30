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
    
    let labelHeight: CGFloat = Utility.tvAppOptionsButtonHeight
    
    var body: some View {
        Rectangle()
            .overlay {
                ZStack {
                    if let imageValue = image.imageValue {
                        imageValue.resizable().scaledToFill()
                    }
                }
                .modifier(OptionButtonSelected(isSelected: isSelected()))
                
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
