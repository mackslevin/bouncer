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
    @Query var userImages: [AppImage]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Backgrounds")
                        .font(.title3)
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem()], content: {
                            ForEach(userImages.filter({$0.imageType == .background}).sorted()) { userImage in
                                
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
                    .padding(.bottom, 50)
                    
                    Text("Box Images")
                        .font(.title3)
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem()], content: {
                            ForEach(userImages.filter({$0.imageType == .boxImage}).sorted()) { userImage in
                                
                                    Button {
                                        contentViewModel.boxImage = userImage
                                    } label: {
                                        OptionsRowButtonLabel(contentViewModel: contentViewModel, image: userImage, imageType: .boxImage)
                                    }
                                    .buttonStyle(OptionsRowButtonStyle())
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                
                            }
                        })
                    }
                    .padding(.bottom, 50)
                    
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") { dismiss() }
                    }
                }
                .navigationTitle("Settings")
            }
            
        }
    }
}

#Preview {
    OptionsView()
}
