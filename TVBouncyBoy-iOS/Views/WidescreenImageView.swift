//
//  WidescreenImageView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/22/24.
//

import SwiftUI

struct WidescreenImageView: View {
    let image: Image
    
    var body: some View {
        Rectangle()
            .foregroundStyle(Color.clear)
            .aspectRatio(16/9, contentMode: .fit)
            .overlay {
                image.resizable().scaledToFill()
            }
            .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
    }
}

//#Preview {
//    WidescreenImageView()
//}
