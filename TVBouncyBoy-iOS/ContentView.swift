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
    @Query var userImages: [UserImage]
    @State private var vm = ContentViewModel()
    @ObservedObject var photosPickerManager = PhotosPickerManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                GroupBox(label: Text("Backgrounds"), content: {
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
                                if let data = userImage.data, let uiImage = UIImage(data: data) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: vm.rowHeight)
                                        .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                                }
                            }
                        })
                    }
                })
                
                GroupBox(label: Text("Box Images"), content: {
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
                                if let data = userImage.data, let uiImage = UIImage(data: data) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: vm.rowHeight)
                                        .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                                }
                            }
                        })
                    }
                })
                
                
                Spacer()
            }
            .padding()
            .navigationTitle("TV Bouncy Boy")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: UserImage.self, inMemory: true)
}
