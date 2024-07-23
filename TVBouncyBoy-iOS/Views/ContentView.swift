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
    
    
    let gridRows: [GridItem] = [GridItem(), GridItem()]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Box Images")
                        .font(.title2)
                        .bold()
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridRows, content: {
                            PhotosPicker(selection: $photosPickerManager.boxImageSelection, matching: .images) {
                                Rectangle()
                                    .aspectRatio(16/9, contentMode: .fit)
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
                            
                            ForEach(userImages.filter({$0.imageType == .boxImage}).sorted()) { userImage in
                                if let image = userImage.imageValue {
                                    WidescreenImageView(image: image)
                                        .contextMenu {
                                            Button("Delete", systemImage: "trash", role: .destructive) {
                                                withAnimation {
                                                    modelContext.delete(userImage)
                                                }
                                            }
                                        }
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
                        
                    }
                    .frame(minHeight: vm.rowHeight * CGFloat(gridRows.count))
                    
                }
                .padding(.vertical)
                
                VStack(alignment: .leading) {
                    Text("Backgrounds")
                        .font(.title2)
                        .bold()
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(), GridItem()], content: {
                            PhotosPicker(selection: $photosPickerManager.backgroundImageSelection, matching: .images) {
                                Rectangle()
                                    .aspectRatio(16/9, contentMode: .fit)
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
                            
                            ForEach(userImages.filter({$0.imageType == .background}).sorted()) { userImage in
                                if let image = userImage.imageValue {
                                    WidescreenImageView(image: image)
                                        .contextMenu {
                                            Button("Delete", systemImage: "trash", role: .destructive) {
                                                withAnimation {
                                                    modelContext.delete(userImage)
                                                }
                                            }
                                        }
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
                    }
                    .frame(minHeight: vm.rowHeight * CGFloat(gridRows.count))
                }
                .padding(.vertical)
            }
            .padding()
            .navigationTitle("TV Bouncy Boy")
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
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: AppImage.self, inMemory: true)
}
