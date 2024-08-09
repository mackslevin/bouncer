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
                        
                        Text("Stills")
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
                            .padding(.top)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()], content: {
                                Button {
                                    withAnimation {
                                        homeVM.foregroundMode = .clock1
                                        homeVM.boxImage = nil
                                    }
                                } label: {
                                    Clock1View()
                                        .modifier(OptionButtonSelected(isSelected: homeVM.foregroundMode == .clock1))
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                .aspectRatio(16/9, contentMode: .fit)
                                .frame(height: Utility.tvAppOptionsButtonHeight)
                                
                                Button {
                                    withAnimation {
                                        homeVM.foregroundMode = .clock2
                                        homeVM.boxImage = nil
                                    }
                                } label: {
                                    Clock2View()
                                        .modifier(OptionButtonSelected(isSelected: homeVM.foregroundMode == .clock2))
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                .aspectRatio(16/9, contentMode: .fit)
                                .frame(height: Utility.tvAppOptionsButtonHeight)
                                
                                Button {
                                    withAnimation {
                                        homeVM.foregroundMode = .clock3
                                        homeVM.boxImage = nil
                                    }
                                } label: {
                                    Clock3View()
                                        .modifier(OptionButtonSelected(isSelected: homeVM.foregroundMode == .clock3))
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                .aspectRatio(16/9, contentMode: .fit)
                                .frame(height: Utility.tvAppOptionsButtonHeight)
                                
                                Button {
                                    withAnimation {
                                        homeVM.foregroundMode = .clock4
                                        homeVM.boxImage = nil
                                    }
                                } label: {
                                    Clock4View()
                                        .modifier(OptionButtonSelected(isSelected: homeVM.foregroundMode == .clock4))
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                .aspectRatio(16/9, contentMode: .fit)
                                .frame(height: Utility.tvAppOptionsButtonHeight)
                                
                                Button {
                                    withAnimation {
                                        homeVM.foregroundMode = .clock5
                                        homeVM.boxImage = nil
                                    }
                                } label: {
                                    Clock5View()
                                        .modifier(OptionButtonSelected(isSelected: homeVM.foregroundMode == .clock5))
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                .aspectRatio(16/9, contentMode: .fit)
                                .frame(height: Utility.tvAppOptionsButtonHeight)
                            })
                        }
                        
                        
                        Text("Misc.")
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                            .padding(.top)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()], content: {
                                VStack {
                                    Button {
                                        withAnimation {
                                            homeVM.boxImage = nil
                                            homeVM.foregroundMode = .emoji1
                                        }
                                    } label: {
                                        Emoji1View(bounceVM: BounceViewModel())
                                            .modifier(OptionButtonSelected(isSelected: homeVM.foregroundMode == .emoji1))
                                    }
                                    .buttonStyle(OptionsRowButtonStyle())
                                    .aspectRatio(16/9, contentMode: .fit)
                                    .frame(height: Utility.tvAppOptionsButtonHeight)
                                    Text("Emoji Faces").font(.caption2).foregroundStyle(.secondary)
                                }
                                
                                VStack {
                                    Button {
                                        withAnimation {
                                            homeVM.boxImage = nil
                                            homeVM.foregroundMode = .emoji2
                                        }
                                    } label: {
                                        Emoji2View(bounceVM: BounceViewModel())
                                            .frame(width: Utility.tvAppOptionsButtonHeight * 1.77, height: Utility.tvAppOptionsButtonHeight)
                                            .modifier(OptionButtonSelected(isSelected: homeVM.foregroundMode == .emoji2))
                                    }
                                    .buttonStyle(OptionsRowButtonStyle())
                                    Text("Emoji Animals").font(.caption2).foregroundStyle(.secondary)
                                }
                                
                                VStack {
                                    Button {
                                        withAnimation {
                                            homeVM.boxImage = nil
                                            homeVM.foregroundMode = .trivia1
                                        }
                                    } label: {
                                        Trivia1View()
                                            .frame(width: Utility.tvAppOptionsButtonHeight * 1.77, height: Utility.tvAppOptionsButtonHeight)
                                            .modifier(OptionButtonSelected(isSelected: homeVM.foregroundMode == .trivia1))
                                    }
                                    .buttonStyle(OptionsRowButtonStyle())
                                    Text("Trivia").font(.caption2).foregroundStyle(.secondary)
                                }
                                
                            })
                        }
                        
                        
                        Text("My Images")
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                            .padding(.top)
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
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: Utility.defaultCornerRadius)
                            .foregroundStyle(.regularMaterial)
                    }
                    .padding(.top)
                    
                    VStack(alignment: .leading) {
                        Text("Background")
                            .font(Font.displayFont(size: 48))
                            .foregroundStyle(.accent)
                        
                        Text("Stills")
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
                                
                                Button {
                                    withAnimation {
                                        homeVM.backgroundImage = nil
                                        homeVM.backgroundMode = .colorBars
                                    }
                                } label: {
                                    ColorBarsView()
                                        .frame(height: Utility.tvAppOptionsButtonHeight)
                                        .aspectRatio(16/9, contentMode: .fill)
                                        .modifier(OptionButtonSelected(isSelected: homeVM.backgroundMode == .colorBars))
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                            })
                        }
                        .padding(.bottom)
                        
                        Text("Colors")
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()], content: {
                                
                                Button {
                                    withAnimation {
                                        homeVM.backgroundImage = nil
                                        homeVM.backgroundMode = .colorGrad1
                                    }
                                } label: {
                                    BackgroundModeButtonLabel(homeVM: homeVM, mode: .colorGrad1) {
                                        ColorGrad1View()
                                    }
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                
                                Button {
                                    withAnimation {
                                        homeVM.backgroundImage = nil
                                        homeVM.backgroundMode = .colorGrad2
                                    }
                                } label: {
                                    BackgroundModeButtonLabel(homeVM: homeVM, mode: .colorGrad2) {
                                        ColorGrad2View()
                                    }
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                
                                Button {
                                    withAnimation {
                                        homeVM.backgroundImage = nil
                                        homeVM.backgroundMode = .colorGrad3
                                    }
                                } label: {
                                    BackgroundModeButtonLabel(homeVM: homeVM, mode: .colorGrad3) {
                                        ColorGrad3View()
                                    }
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                
                                Button {
                                    withAnimation {
                                        homeVM.backgroundImage = nil
                                        homeVM.backgroundMode = .colorGrad4
                                    }
                                } label: {
                                    BackgroundModeButtonLabel(homeVM: homeVM, mode: .colorGrad4) {
                                        ColorGrad4View()
                                    }
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                
                                Button {
                                    withAnimation {
                                        homeVM.backgroundImage = nil
                                        homeVM.backgroundMode = .colorGrad5
                                    }
                                } label: {
                                    BackgroundModeButtonLabel(homeVM: homeVM, mode: .colorGrad5) {
                                        ColorGrad5View()
                                    }
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                
                                Button {
                                    withAnimation {
                                        homeVM.backgroundImage = nil
                                        homeVM.backgroundMode = .colorGrad6
                                    }
                                } label: {
                                    BackgroundModeButtonLabel(homeVM: homeVM, mode: .colorGrad6) {
                                        ColorGrad6View()
                                    }
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                                
                                Button {
                                    withAnimation {
                                        homeVM.backgroundImage = nil
                                        homeVM.backgroundMode = .colorGrad7
                                    }
                                } label: {
                                    BackgroundModeButtonLabel(homeVM: homeVM, mode: .colorGrad7) {
                                        ColorGrad7View()
                                    }
                                }
                                .buttonStyle(OptionsRowButtonStyle())
                            })
                        }
                        
                        
                        Text("Now Playing")
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        Text("If you're playing from the Music app, these backgrounds will display info about the current song.")
                            .fontDesign(.rounded)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()], content: {
                                VStack {
                                    Button {
                                        withAnimation {
                                            homeVM.backgroundMode = .nowPlaying1
                                            homeVM.backgroundImage = nil
                                        }
                                    } label: {
                                        BackgroundModeButtonLabel(homeVM: homeVM, mode: .nowPlaying1) {
                                            NowPlaying1PreviewView()
                                        }
                                    }
                                    .buttonStyle(OptionsRowButtonStyle())
                                    Text("Minimal")
                                        .font(.caption2).foregroundStyle(.secondary)
                                }
                                
                                VStack {
                                    Button {
                                        withAnimation {
                                            homeVM.backgroundMode = .nowPlaying2
                                            homeVM.backgroundImage = nil
                                        }
                                    } label: {
                                        BackgroundModeButtonLabel(homeVM: homeVM, mode: .nowPlaying2) {
                                            NowPlaying2PreviewView()
                                        }
                                    }
                                    .buttonStyle(OptionsRowButtonStyle())
                                    Text("Big Cover").font(.caption2).foregroundStyle(.secondary)
                                }
                                
                                VStack {
                                    Button {
                                        withAnimation {
                                            homeVM.backgroundMode = .nowPlaying3
                                            homeVM.backgroundImage = nil
                                        }
                                    } label: {
                                        BackgroundModeButtonLabel(homeVM: homeVM, mode: .nowPlaying3) {
                                            NowPlaying3PreviewView()
                                        }
                                    }
                                    .buttonStyle(OptionsRowButtonStyle())
                                    Text("Big Text").font(.caption2).foregroundStyle(.secondary)
                                }
                                
                            })
                        }
                        
                        Text("My Images")
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                            .padding(.top)
                        
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
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: Utility.defaultCornerRadius)
                            .foregroundStyle(.regularMaterial)
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
