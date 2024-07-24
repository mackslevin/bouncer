//
//  OptionsRowButtonLabel.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI

struct OptionsRowButtonLabel: View {
    @Bindable var contentViewModel: BounceViewModel
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
        contentViewModel.boxImage == image || contentViewModel.backgroundImage == image
    }
}

//#Preview {
//    OptionsRowButtonLabel()
//}
