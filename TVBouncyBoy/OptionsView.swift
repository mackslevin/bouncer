//
//  OptionsView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/11/24.
//

import SwiftUI

struct OptionsView: View {
    @Bindable var contentViewModel = ContentViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Background")
                    .font(.title3)
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [GridItem()], content: {
                        ForEach(CoolBackground.allCases.reversed(), id: \.self) { bg in
                            
                            Button {
                                contentViewModel.backgroundType = bg
                            } label: {
                                ZStack {
                                    Color.white
                                    Rectangle()
                                        .overlay {
                                            CoolBackgroundView(backgroundType: bg)
                                        }
                                        .clipped()
                                        .padding(contentViewModel.backgroundType == bg ? 10 : 0)
                                }
                                .frame(width: 400, height: 240)
                            }
                            .buttonStyle(OptionsRowButtonStyle())
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        }
                    })
                }
                
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    OptionsView()
}
