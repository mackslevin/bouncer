//
//  OptionButtonSelected.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/30/24.
//

import SwiftUI


struct OptionButtonSelected: ViewModifier {
    let isSelected: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isSelected {
                    Color.black.opacity(0.5)
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: Utility.tvAppOptionsButtonHeight * 0.6)
                        .foregroundStyle(.white)
                        .shadow(radius: 4)
                }
            }
    }
}

//extension View {
//    func optionButtonSelected(isSelected: Bool) {
//        self.modifier(OptionButtonSelected(isSelected: isSelected))
//    }
//}
