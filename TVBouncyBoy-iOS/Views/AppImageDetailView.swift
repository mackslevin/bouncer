//
//  UserImageDetailView.swift
//  TVBouncyBoy-iOS
//
//  Created by Mack Slevin on 7/23/24.
//

import SwiftUI

struct AppImageDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var appImage: AppImage?
    let onDelete: () -> Void
    
    @AppStorage(StorageKeys.warnBeforeDelete.rawValue) var shouldWarnBeforeDeleting: Bool = true
    @State private var isShowingDeleteWarning: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                if let img = appImage?.imageValue {
                    WidescreenImageView(image: img)
                    
                    HStack(spacing: 50) {
                        ShareLink(item: img, preview: SharePreview("Image", image: img))
                            .buttonStyle(.bordered)
                            .fontWeight(.medium)
                        
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            if shouldWarnBeforeDeleting {
                                isShowingDeleteWarning.toggle()
                            } else {
                                dismiss()
                                onDelete()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .fontWeight(.bold)
                        .alert("Are you sure you want to delete this image? This cannot be undone.", isPresented: $isShowingDeleteWarning) {
                            Button("Delete", role: .destructive) {
                                dismiss()
                                onDelete()
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

//#Preview {
//    AppImageDetailView()
//}
