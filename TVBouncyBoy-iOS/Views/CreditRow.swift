//
//  CreditRow.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/31/24.
//

import SwiftUI


struct CreditRow: View {
    let credit: PhotoCredit
    let imageHeight: CGFloat
    var body: some View {
        HStack() {
            VStack {
                WidescreenImageView(image: Image(credit.imageNames.first!))
                    .frame(height: imageHeight)
                    .overlay(alignment: .topLeading) {
                        AsyncImage(url: credit.photographerImageURL) { image in
                            image.resizable().scaledToFill()
                                .clipShape(RoundedRectangle(cornerRadius: Utility.defaultCornerRadius))
                                .aspectRatio(1, contentMode: .fit)
                                .frame(height: imageHeight/2)
                                .padding(4)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: Utility.defaultCornerRadius)
                                .foregroundStyle(.accent.gradient)
                                .aspectRatio(1, contentMode: .fit)
                                .frame(height: imageHeight)
                                .padding()
                        }
                    }
                
                if Utility.isTV() {
                    Text(credit.name)
                        .bold()
                }
            }
            
            if !Utility.isTV() {
                VStack(alignment: .leading, content: {
                    Text(credit.name)
                        .bold()
                        .onTapGesture {
                            print("^^ tap")
                        }
                    
                    Label("Unsplash", systemImage: "arrow.up.forward.square")
                })
            }
            
        }
    }
}
