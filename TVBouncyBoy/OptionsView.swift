//
//  OptionsView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/11/24.
//

import SwiftUI
import SwiftData

struct OptionsView: View {
    @Bindable var contentViewModel = ContentViewModel()
    @Environment(\.dismiss) var dismiss
    @Query var userImages: [UserImage]
    
    let backgroundPresets: [Preset] = [
        Preset(image: Image("lake")),
        Preset(image: Image("blue-cloth")),
        Preset(image: Image("color-puffs")),
        Preset(image: Image("test"))
    ]
    
    let boxImagePresets: [Preset] = [
        Preset(image: Image("randy")),
        Preset(image: Image("used-to-this"))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Background Presets")
                        .font(.title3)
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem()], content: {
                            ForEach(backgroundPresets) { preset in
                                Button {
                                    contentViewModel.backgroundImage = preset.image
                                } label: {
                                    OptionsRowButtonLabel(contentViewModel: contentViewModel, image: preset.image, imageType: .background)
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        })
                    }
                    .padding(.bottom, 50)
                    
                    Text("Custom Backgrounds")
                        .font(.title3)
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem()], content: {
                            ForEach(userImages.filter({$0.imageType == .background}).sorted()) { userImage in
                                if let data = userImage.data, let uiImage = UIImage(data: data) {
                                    Button {
                                        contentViewModel.backgroundImage = Image(uiImage: uiImage)
                                    } label: {
                                        OptionsRowButtonLabel(contentViewModel: contentViewModel, image: Image(uiImage: uiImage), imageType: .background)
                                    }
                                    .buttonStyle(OptionsRowButtonStyle())
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                
                            }
                        })
                    }
                    .padding(.bottom, 50)
                    
                    Text("Box Image Presets")
                        .font(.title3)
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem()], content: {
                            ForEach(boxImagePresets) { preset in
                                
                                Button {
                                    contentViewModel.boxImage = preset.image
                                } label: {
                                    OptionsRowButtonLabel(contentViewModel: contentViewModel, image: preset.image, imageType: .boxImage)
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        })
                    }
                    .padding(.bottom, 50)
                    
                    Text("Custom Box Images")
                        .font(.title3)
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem()], content: {
                            ForEach(userImages.filter({$0.imageType == .boxImage}).sorted()) { userImage in
                                if let data = userImage.data, let uiImage = UIImage(data: data) {
                                    Button {
                                        contentViewModel.boxImage = Image(uiImage: uiImage)
                                    } label: {
                                        OptionsRowButtonLabel(contentViewModel: contentViewModel, image: Image(uiImage: uiImage), imageType: .boxImage)
                                    }
                                    .buttonStyle(OptionsRowButtonStyle())
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                
                            }
                        })
                    }
                    .padding(.bottom, 50)
                    
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") { dismiss() }
                    }
                }
                .navigationTitle("Settings")
            }
            
        }
    }
}

#Preview {
    OptionsView()
}
