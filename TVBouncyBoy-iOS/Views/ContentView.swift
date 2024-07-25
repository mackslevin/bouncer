//
//  ContentView.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/18/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var userImages: [AppImage]
    @State private var vm = ContentViewModel()
    @ObservedObject var photosPickerManager = PhotosPickerManager()
    @AppStorage(StorageKeys.warnBeforeDelete.rawValue) var shouldWarnBeforeDeleting: Bool = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("My Box Images")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal, vm.horizontalPadding)
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: vm.dynamicGridRows(appImages: userImages, type: .boxImage), content: {
                            PhotosPicker(selection: $photosPickerManager.boxImageSelection, matching: .images) {
                                Rectangle()
                                    .aspectRatio(16/9, contentMode: .fit)
                                    .frame(height: vm.rowHeight)
                                    .overlay {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(vm.rowHeight/3)
                                            .foregroundStyle(.primary)
                                            .colorInvert()
                                        
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                                    .tint(.secondary)
                            }
                            .zIndex(101)
                            
                            ForEach(userImages.filter({
                                $0.imageType == .boxImage && $0.presetName == nil
                            }).sorted()) { userImage in
                                if let image = userImage.imageValue {
                                    WidescreenImageView(image: image)
                                        .frame(height: vm.rowHeight)
                                        .overlay {
                                            VStack {
                                                Button {
                                                    vm.selectedImage = userImage
                                                    vm.isShowingImageDetail = true
                                                } label: {
                                                    Image(systemName: "ellipsis.circle.fill")
                                                        .resizable().scaledToFit()
                                                        .foregroundStyle(.regularMaterial)
                                                        .frame(width: vm.rowHeight/4)
                                                        .padding(6)
                                                }
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                        }
                                }
                            }
                        })
                        .scrollTargetLayout()
                        
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .safeAreaPadding(.horizontal, vm.horizontalPadding)
                }
                .padding(.vertical)
                
                VStack(alignment: .leading) {
                    Text("My Backgrounds")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal, vm.horizontalPadding)
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: vm.dynamicGridRows(appImages: userImages, type: .background), content: {
                            PhotosPicker(selection: $photosPickerManager.backgroundImageSelection, matching: .images) {
                                Rectangle()
                                    .aspectRatio(16/9, contentMode: .fit)
                                    .frame(height: vm.rowHeight)
                                    .overlay {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(vm.rowHeight/3)
                                            .foregroundStyle(.primary)
                                            .colorInvert()
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                                    .tint(.secondary)
                            }
                            .zIndex(101)
                            
                            ForEach(userImages.filter({
                                $0.imageType == .background && $0.presetName == nil
                            }).sorted()) { userImage in
                                if let image = userImage.imageValue {
                                    WidescreenImageView(image: image)
                                        .frame(height: vm.rowHeight)
                                        .overlay {
                                            VStack {
                                                Button {
                                                    vm.selectedImage = userImage
                                                    vm.isShowingImageDetail = true
                                                } label: {
                                                    Image(systemName: "ellipsis.circle.fill")
                                                        .resizable().scaledToFit()
                                                        .foregroundStyle(.regularMaterial)
                                                        .frame(width: vm.rowHeight/4)
                                                        .padding(6)
                                                }
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                        }
                                }
                            }
                        })
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .safeAreaPadding(.horizontal, vm.horizontalPadding)
                }
                .padding(.vertical)
            }
            .toolbarTitleDisplayMode(.inline)
            .sheet(isPresented: $vm.isShowingImageDetail, content: {
                AppImageDetailView(appImage: $vm.selectedImage) {
                    // Callback on user selecting "delete"
                    withAnimation {
                        guard let image = vm.selectedImage else { return }
                        modelContext.delete(image)
                    }
                }
                .presentationDetents([.medium])
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Button("Foo", systemImage: "circle") {
                            // Taking up some space so the logo is centered
                        }.opacity(0).accessibilityHidden(true)
                        Spacer()
                        Image("logo-accent") // Replace "YourLogo" with the name of your image asset
                            .resizable()
                            .scaledToFit()
                            .frame(height: 24) // Adjust the height as needed
                        Spacer()
                        Button("Settings", systemImage: "gear") {
                            vm.isShowingSettings.toggle()
                        }
                    }
                }
            }
            .sheet(isPresented: $vm.isShowingSettings, content: {
                SettingsView()
            })
        }
    }
}

#Preview {
    HomeView()
//    ContentView()
        .modelContainer(for: AppImage.self, inMemory: true)
}
