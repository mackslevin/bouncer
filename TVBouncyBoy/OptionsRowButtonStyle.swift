//
//  BlankButtonStyle.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/11/24.
//

import SwiftUI

struct OptionsRowButtonStyle: ButtonStyle {
    @Environment(\.isFocused) var isFocused
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay {
                Color.black
                    .opacity(isFocused ? 0 : 0.4)
                    .shadow(radius: isFocused ? 50 : 0)
            }
    }
}
