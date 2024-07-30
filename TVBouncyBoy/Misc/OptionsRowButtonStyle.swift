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
        ZStack {
            
            configuration.label
                .overlay(content: {
                    Color.black
                        .opacity(isFocused ? 0.2 : 0)
                })
                .border(
                    Color.white,
                    width: isFocused ? 10 : 0
                )
                .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
        }
        
    }
}
