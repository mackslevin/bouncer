//
//  OptionsView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/11/24.
//

import SwiftUI
import SwiftData

struct OptionsView: View {
    @Bindable var contentViewModel = BounceViewModel()
    @Environment(\.dismiss) var dismiss
    @Query var appImages: [AppImage]
    @State private var vm = OptionsViewModel()
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 50) {
                    VStack(alignment: .leading) {
                        Text("Bouncing Image")
                            .font(Font.displayFont(size: 48))
                        
                        Text("Presets")
                            .fontDesign(.rounded)
                            .foregroundStyle(.secondary)
                        
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()], content: {
                                ForEach(vm.presetImages(appImages: appImages, type: .boxImage)) { userImage in
                                        Button { contentViewModel.boxImage = userImage } label: {
                                            OptionsRowButtonLabel(contentViewModel: contentViewModel, image: userImage, imageType: .boxImage)
                                        }
                                        .buttonStyle(OptionsRowButtonStyle())
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            })
                        }
                        
                        Text("Custom")
                            .fontDesign(.rounded)
                            .foregroundStyle(.secondary)
                        if vm.customImages(appImages: appImages, type: .boxImage).isEmpty {
                            UploadOnCompanionApp()
                        } else {
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: [GridItem()], content: {
                                    ForEach(vm.customImages(appImages: appImages, type: .boxImage)) { userImage in
                                            Button { contentViewModel.boxImage = userImage } label: {
                                                OptionsRowButtonLabel(contentViewModel: contentViewModel, image: userImage, imageType: .boxImage)
                                            }
                                            .buttonStyle(OptionsRowButtonStyle())
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                })
                            }
                            .padding(.bottom)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Background")
                            .font(Font.displayFont(size: 48))
                        
                        Text("Presets")
                            .fontDesign(.rounded)
                            .foregroundStyle(.secondary)
                        
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()], content: {
                                ForEach(vm.presetImages(appImages: appImages, type: .background)) { userImage in
                                    
                                    Button {
                                        contentViewModel.backgroundImage = userImage
                                    } label: {
                                        OptionsRowButtonLabel(contentViewModel: contentViewModel, image: userImage, imageType: .background)
                                    }
                                    .buttonStyle(OptionsRowButtonStyle())
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            })
                        }
                        .padding(.bottom)
                        
                        Text("Custom")
                            .fontDesign(.rounded)
                            .foregroundStyle(.secondary)
                        
                        if vm.customImages(appImages: appImages, type: .background).isEmpty {
                            UploadOnCompanionApp()
                        } else {
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: [GridItem()], content: {
                                    ForEach(vm.customImages(appImages: appImages, type: .background)) { userImage in
                                        
                                        Button {
                                            contentViewModel.backgroundImage = userImage
                                        } label: {
                                            OptionsRowButtonLabel(contentViewModel: contentViewModel, image: userImage, imageType: .background)
                                        }
                                        .buttonStyle(OptionsRowButtonStyle())
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                })
                            }
                            .padding(.bottom)
                        }
                    }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Settings", systemImage: "gear") { vm.isShowingSettings.toggle() }
                            .fontDesign(.rounded)
                            .labelStyle(.titleOnly)
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Close") { dismiss() }
                    }
                }
                .navigationTitle("Setup")
                .sheet(isPresented: $vm.isShowingSettings, content: {
                    SettingsView()
                })
            }
            
        }
    }
}

#Preview {
    OptionsView()
}
