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
                        Text("Box Image")
                            .font(.title3).bold()
                        
                        Text("Presets").foregroundStyle(.secondary)
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
                        
                        Text("Custom").foregroundStyle(.secondary)
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
                            .font(.title3).bold()
                        
                        Text("Presets").foregroundStyle(.secondary)
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
                        
                        Text("Custom").foregroundStyle(.secondary)
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
                    
                    Button("Settings", systemImage: "gear") { vm.isShowingSettings.toggle() }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Close") { dismiss() }.bold()
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
