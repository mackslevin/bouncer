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
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                if let img = appImage?.imageValue {
                    WidescreenImageView(image: img)
                    
                    HStack(spacing: 50) {
                        ShareLink(item: img, preview: SharePreview("Image", image: img))
                            .buttonStyle(.bordered)
                        
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            dismiss()
                            onDelete()
                        }
                        .buttonStyle(.borderedProminent)
                        .fontWeight(.medium)
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
