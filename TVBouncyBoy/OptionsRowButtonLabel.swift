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
    
    var body: some View {
        ZStack {
            Color.white
            Rectangle()
                .overlay {
                    if let imageValue = image.imageValue {
                        imageValue.resizable().scaledToFill()
                    }
                }
                .clipped()
                .padding(
                    contentViewModel.boxImage == image || contentViewModel.backgroundImage == image ? 10 : 0
                )
        }
        .frame(width: 400, height: 240)
    }
}

//#Preview {
//    OptionsRowButtonLabel()
//}
