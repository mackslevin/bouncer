//
//  OptionsView.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/11/24.
//

import SwiftUI
import SwiftData

struct OptionsView: View {
    @Bindable var homeVM: TVHomeViewModel
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
                            .foregroundStyle(.accent)
                        
                        Text("Presets")
                            .fontDesign(.rounded)
                            .foregroundStyle(.secondary)
                        
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()], content: {
                                ForEach(vm.presetImages(appImages: appImages, type: .boxImage)) { userImage in
                                        Button { homeVM.boxImage = userImage } label: {
                                            OptionsRowButtonLabel(homeVM: homeVM, image: userImage, imageType: .boxImage)
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
                                            Button { homeVM.boxImage = userImage } label: {
                                                OptionsRowButtonLabel(homeVM: homeVM, image: userImage, imageType: .boxImage)
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
                            .foregroundStyle(.accent)
                        
                        Text("Presets")
                            .fontDesign(.rounded)
                            .foregroundStyle(.secondary)
                        
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()], content: {
                                ForEach(vm.presetImages(appImages: appImages, type: .background)) { userImage in
                                    
                                    Button {
                                        homeVM.backgroundMode = .standardBounce
                                        homeVM.backgroundImage = userImage
                                    } label: {
                                        OptionsRowButtonLabel(homeVM: homeVM, image: userImage, imageType: .background)
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
                                            homeVM.backgroundMode = .standardBounce
                                            homeVM.backgroundImage = userImage
                                        } label: {
                                            OptionsRowButtonLabel(homeVM: homeVM, image: userImage, imageType: .background)
                                        }
                                        .buttonStyle(OptionsRowButtonStyle())
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                })
                            }
                            .padding(.bottom)
                        }
                        
                        Text("Now Playing")
                            .fontDesign(.rounded)
                            .foregroundStyle(.secondary)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()], content: {
                                Button {
                                    withAnimation {
                                        homeVM.backgroundImage = nil
                                        homeVM.backgroundMode = .nowPlaying1
                                    }
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .aspectRatio(16/9, contentMode: .fit)
                                            .frame(height: 150)
                                            .foregroundStyle(.accent.gradient)
                                            .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                                        
                                        Text("Now Playing 1")
                                    }
                                    .overlay {
                                        ZStack {
                                            Color.black.opacity(0.5)
                                            Image(systemName: "checkmark.circle.fill").resizable().scaledToFit()
                                                .frame(height: 150 * 0.6)
                                                .foregroundStyle(.white)
                                                .shadow(radius: 4)
                                        }
                                        .opacity(homeVM.backgroundMode == .nowPlaying1 ? 1 : 0)
                                    }
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                            })
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
    OptionsView(homeVM: TVHomeViewModel())
}
