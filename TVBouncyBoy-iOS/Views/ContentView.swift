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
            ScrollView {
                
                if
                    let id = vm.selectedImageID,
                    let usrImage = userImages.first(where: {$0.id == id}),
                    let image = usrImage.imageValue
                {
//                    image.resizable().scaledToFill()
//                        .clipShape(
//                            RoundedRectangle(cornerRadius: Utility.defaultCornerRadius)
//                                
//                        )
//                        .aspectRatio(16/9, contentMode: .fit)
                    
                    Rectangle()
                        .aspectRatio(16/9, contentMode: .fit)
                        .overlay {
                            image.resizable().scaledToFill()
                        }
                        .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                } else {
                    ZStack {
                        Rectangle()
                            .foregroundStyle(Color.secondary.gradient)
                        Image(systemName: "photo")
                            .resizable().scaledToFit()
                            .padding(50)
                            .foregroundStyle(.tertiary)
                    }
                    .aspectRatio(16/9, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                }
                
                VStack(alignment: .leading) {
                    Text("Box Images")
                        .font(.title2)
                        .bold()
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem()], content: {
                            PhotosPicker(selection: $photosPickerManager.boxImageSelection, matching: .images) {
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
                                    WidescreenImageView(image: image)
                                        .contextMenu {
                                            Button("Delete", systemImage: "trash", role: .destructive) {
                                                withAnimation {
                                                    modelContext.delete(userImage)
                                                }
                                            }
                                        }
                                        .onTapGesture {
                                            vm.toggleSelected(id: userImage.id)
                                        }
                                }
                            }
                        })
                    }
                    .frame(height: vm.rowHeight)
                }
                .padding(.vertical)
                
                VStack(alignment: .leading) {
                    Text("Backgrounds")
                        .font(.title2)
                        .bold()
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem()], content: {
                            PhotosPicker(selection: $photosPickerManager.backgroundImageSelection, matching: .images) {
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
                                    WidescreenImageView(image: image) 
                                        .contextMenu {
                                            Button("Delete", systemImage: "trash", role: .destructive) {
                                                withAnimation {
                                                    modelContext.delete(userImage)
                                                }
                                            }
                                        }
                                        .onTapGesture {
                                            vm.toggleSelected(id: userImage.id)
                                        }
                                }
                            }
                        })
                    }
                    .frame(height: vm.rowHeight)
                }
                .padding(.vertical)
                
                
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
