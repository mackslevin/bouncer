//
//  CompanionAppPhotoCreditsView.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/31/24.
//

import SwiftUI

struct PhotoCreditsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var imageHeight: CGFloat = 100
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    #if os(tvOS)
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 50, content: {
                        ForEach(PhotoCredit.credits) { credit in
                            CreditRow(credit: credit, imageHeight: imageHeight * 2)
                        }
                    })
                    .padding(.vertical, 40)
                    #else
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(PhotoCredit.credits) { credit in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .overlay{Image(credit.imageNames.first!)}
                                Rectangle().foregroundStyle(.regularMaterial)
                                CreditRow(credit: credit, imageHeight: imageHeight)
                                    .padding(10)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                            
                        }
                    }
                    #endif
                }
                .navigationTitle("Photo Credits")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.horizontal)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close", systemImage: "xmark") {
                            dismiss()
                        }
                        .labelStyle(.titleOnly)
                    }
                }
                .fontDesign(.rounded)
                
            }
        }
    }
}



#Preview {
    PhotoCreditsView()
}
