//
//  CircularImage.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 30/04/24.
//

import SwiftUI

struct CircularImage: View {
    var width: CGFloat = 100
    var height: CGFloat = 100
    var strokeColor: Color = Color.tertiaryWhite
    var icon: String
    var isSystemIcon: Bool = false
    
    var body: some View {
        Circle()
            .stroke(strokeColor, lineWidth: 2)
            .overlay(
                imageForType
                    .resizable()
                    .scaledToFill()
                    .padding(isSystemIcon ? 16 : 0)
                    .foregroundStyle(strokeColor)
                    .clipShape(Circle())
            )
            .frame(width: width, height: height)
    }
    
    private var imageForType: Image {
        if isSystemIcon {
            return Image(systemName: icon) // Initializes a system symbol image
        } else {
            return Image(icon) // Initializes an image from an asset
        }
    }
}

#Preview {
    CircularImage(width: 100, height: 100, strokeColor: Color.regularGreen ,icon: "mug.fill", isSystemIcon: true)
}
