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
                        
                        Text("Preset Images")
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()], content: {
                                ForEach(vm.presetImages(appImages: appImages, type: .boxImage)) { userImage in
                                    Button {
                                        homeVM.boxImage = userImage
                                        homeVM.foregroundMode = .standardBounce
                                    } label: {
                                        OptionsRowButtonLabel(homeVM: homeVM, image: userImage, imageType: .boxImage)
                                    }
                                    .buttonStyle(OptionsRowButtonStyle())
                                }
                            })
                        }
                        
                        Text("Clock")
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()], content: {
                                Button {
                                    withAnimation {
                                        homeVM.foregroundMode = .clock1
                                        homeVM.boxImage = nil
                                    }
                                } label: {
                                    Clock1View()
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                            })
                        }
                        
                        Text("My Images")
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                            
                        if vm.customImages(appImages: appImages, type: .boxImage).isEmpty {
                            UploadOnCompanionApp()
                        } else {
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: [GridItem()], content: {
                                    ForEach(vm.customImages(appImages: appImages, type: .boxImage)) { userImage in
                                        Button {
                                            homeVM.boxImage = userImage
                                            homeVM.foregroundMode = .standardBounce
                                        } label: {
                                            OptionsRowButtonLabel(homeVM: homeVM, image: userImage, imageType: .boxImage)
                                        }
                                        .buttonStyle(OptionsRowButtonStyle())

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
                        
                        Text("Preset Images")
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                        
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()], content: {
                                ForEach(vm.presetImages(appImages: appImages, type: .background)) { userImage in
                                    
                                    Button {
                                        homeVM.backgroundImage = userImage
                                        homeVM.backgroundMode = .standardBounce
                                    } label: {
                                        OptionsRowButtonLabel(homeVM: homeVM, image: userImage, imageType: .background)
                                    }
                                    .buttonStyle(OptionsRowButtonStyle())

                                }
                            })
                        }
                        .padding(.bottom)
                        
                        Text("Now Playing")
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                            
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()], content: {
                                Button {
                                    withAnimation { 
                                        homeVM.backgroundMode = .nowPlaying1
                                        homeVM.backgroundImage = nil
                                    }
                                } label: {
                                    BackgroundModeButtonLabel(homeVM: homeVM, mode: .nowPlaying1) {
                                        Text("Now Playing 1")
                                    }
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                
                                Button {
                                    withAnimation {
                                        homeVM.backgroundMode = .nowPlaying2
                                        homeVM.backgroundImage = nil
                                    }
                                } label: {
                                    BackgroundModeButtonLabel(homeVM: homeVM, mode: .nowPlaying2) {
                                        Text("Now Playing 2")
                                    }
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                
                                Button {
                                    withAnimation {
                                        homeVM.backgroundMode = .nowPlaying3
                                        homeVM.backgroundImage = nil
                                    }
                                } label: {
                                    BackgroundModeButtonLabel(homeVM: homeVM, mode: .nowPlaying3) {
                                        Text("Now Playing 3")
                                    }
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                            })
                        }
                        
                        Text("My Images")
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                        
                        if vm.customImages(appImages: appImages, type: .background).isEmpty {
                            UploadOnCompanionApp()
                        } else {
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: [GridItem()], content: {
                                    ForEach(vm.customImages(appImages: appImages, type: .background)) { userImage in
                                        
                                        Button {
                                            homeVM.backgroundImage = userImage
                                            homeVM.backgroundMode = .standardBounce
                                        } label: {
                                            OptionsRowButtonLabel(homeVM: homeVM, image: userImage, imageType: .background)
                                        }
                                        .buttonStyle(OptionsRowButtonStyle())

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
                        Button("Close", systemImage: "xmark") { dismiss() }
                            .fontDesign(.rounded)
                            .labelStyle(.titleOnly)
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
