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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                VStack(alignment: .leading) {
                    Text("Backgrounds")
                        .font(.title2)
                        .bold()
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem()], content: {
                            PhotosPicker(selection: $photosPickerManager.backgroundImageSelection) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: Utility.defaultCornerRadius)
                                    Image(systemName: "plus")
                                        .resizable().scaledToFit()
                                        .padding()
                                        .foregroundStyle(Color.primary).colorInvert()
                                }
                                .frame(width: vm.rowHeight, height:  vm.rowHeight)
                                .tint(.secondary)
                            }
                            
                            ForEach(userImages.filter({$0.imageType == .background}).sorted()) { userImage in
                                if let image = userImage.imageValue {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: vm.rowHeight)
                                        .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                                        .contextMenu {
                                            Button("Delete", systemImage: "trash", role: .destructive) {
                                                withAnimation {
                                                    modelContext.delete(userImage)
                                                }
                                            }
                                        }
                                }
                            }
                        })
                    }
                    .frame(height: vm.rowHeight)
                }
                
                VStack(alignment: .leading) {
                    Text("Box Images")
                        .font(.title2)
                        .bold()
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem()], content: {
                            PhotosPicker(selection: $photosPickerManager.boxImageSelection) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: Utility.defaultCornerRadius)
                                    Image(systemName: "plus")
                                        .resizable().scaledToFit()
                                        .padding()
                                        .foregroundStyle(Color.primary).colorInvert()
                                }
                                .frame(width: vm.rowHeight, height:  vm.rowHeight)
                                .tint(.secondary)
                            }
                            
                            ForEach(userImages.filter({$0.imageType == .boxImage}).sorted()) { userImage in
                                if let image = userImage.imageValue {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: vm.rowHeight)
                                        .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                                        .contextMenu {
                                            Button("Delete", systemImage: "trash", role: .destructive) {
                                                withAnimation {
                                                    modelContext.delete(userImage)
                                                }
                                            }
                                        }
                                }
                            }
                        })
                    }
                    .frame(height: vm.rowHeight)
                }
                
                
                Spacer()
            }
            .padding()
            .navigationTitle("TV Bouncy Boy")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: AppImage.self, inMemory: true)
}
