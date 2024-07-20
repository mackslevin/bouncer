//
//  AppImageChooser.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/19/24.
//

import SwiftUI
import SwiftData

struct AppImageChooser: View {
    @Bindable var previewVM: PreviewViewModel
    let imageType: AppImage.ImageType
    
    @State private var cardHeight: CGFloat = 125
    @Query var appImages: [AppImage]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 18, content: {
                        RoundedRectangle(cornerRadius: Utility.defaultCornerRadius)
                            .frame(height: cardHeight)
                            .foregroundStyle(.secondary)
                            .overlay {
                                ZStack {
                                    Image(systemName: "nosign")
                                        .font(.largeTitle).bold()
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                .overlay(alignment: .topTrailing) {
                                    CheckCircle().opacity(isNil() ? 1 : 0)
                                }
                            }
                            .onTapGesture {
                                switch imageType {
                                    case .background:
                                        previewVM.selectedBackgroundImage = nil
                                    case .boxImage:
                                        previewVM.selectedBoxImage = nil
                                }
                                
                                dismiss()
                            }
                        
                        ForEach(appImages.filter({
                            switch imageType {
                                case .background:
                                    $0.imageType == .background
                                case .boxImage:
                                    $0.imageType == .boxImage
                            }
                        })) { ai in
                            Rectangle()
                                .frame(height: cardHeight)
                                .foregroundStyle(.secondary)
                                .overlay {
                                    if let img = ai.imageValue {
                                        img.resizable().scaledToFill()
                                    }
                                }
                                .overlay(alignment: .topTrailing) {
                                    CheckCircle().opacity(isSelected(ai) ? 1 : 0)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                                .onTapGesture {
                                    switch imageType {
                                        case .background:
                                            previewVM.selectedBackgroundImage = ai
                                        case .boxImage:
                                            previewVM.selectedBoxImage = ai
                                    }
                                    
                                    dismiss()
                                }
                        }
                    })
                    
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close", systemImage: "xmark", action: { dismiss() })
                    }
                }
                .padding()
                .navigationTitle(
                    imageType == .background ? "Choose Background" : "Choose Box Image"
                )
                .navigationBarTitleDisplayMode(.inline)
            }
            
        }
    }
    
    func isSelected(_ appImage: AppImage) -> Bool {
        switch imageType {
            case .background:
                previewVM.selectedBackgroundImage == appImage ? true : false
            case .boxImage:
                previewVM.selectedBoxImage == appImage ? true : false
        }
    }
    
    func isNil() -> Bool {
        switch imageType {
            case .background:
                return previewVM.selectedBackgroundImage == nil
            case .boxImage:
                return previewVM.selectedBoxImage == nil
        }
    }
}

#Preview {
    AppImageChooser(previewVM: PreviewViewModel(), imageType: .background)
}
