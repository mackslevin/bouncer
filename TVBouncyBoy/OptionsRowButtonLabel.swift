//
//  OptionsRowButtonLabel.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI

struct OptionsRowButtonLabel: View {
    @Bindable var contentViewModel: ContentViewModel
    let image: Image
    let imageType: UserImage.ImageType
    
    var body: some View {
        ZStack {
            Color.white
            Rectangle()
                .overlay {
                    image.resizable().scaledToFill()
                }
                .clipped()
                .padding(
                    contentViewModel.boxImage == image ? 10 : 0
                )
        }
        .frame(width: 400, height: 240)
    }
}

//#Preview {
//    OptionsRowButtonLabel()
//}
