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
                    Text("My Bouncing Images")
                        .font(Font.displayFont(size: 22))
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
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .safeAreaPadding(.horizontal, vm.horizontalPadding)
                }
                .padding(.vertical)
                
                VStack(alignment: .leading) {
                    Text("My Backgrounds")
                        .font(Font.displayFont(size: 22))
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
                    .scrollIndicators(.hidden)
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
                ToolbarItem(placement: .topBarLeading) {
                    Button("Settings", systemImage: "gear") {
                        vm.isShowingSettings.toggle()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Overview", systemImage: "questionmark.circle") {
                        vm.isShowingOverview.toggle()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Image("logo-accent")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                }
            }
            .sheet(isPresented: $vm.isShowingSettings, content: {
                SettingsView()
            })
            .sheet(isPresented: $vm.isShowingOverview, content: {
                CompanionAppOverviewView()
            })
        }
    }
}

#Preview {
    HomeView()
//    ContentView()
        .modelContainer(for: AppImage.self, inMemory: true)
}
