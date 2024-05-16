//
//  AvatarSelectionView.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 16/05/24.
//

import SwiftUI

struct AvatarSelectionView: View {
  @Binding var selectedAvatar: String

  let avatarNames: [String] = ["profile", "profile2", "profile3", "profile4", "profile5"]

  var body: some View {
          ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 8) {
                  ForEach(avatarNames, id: \.self) { avatarName in
                      Image(avatarName)
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 50, height: 50)
                          .clipShape(Circle())
                          .overlay(
                            Circle()
                                .stroke(avatarName == selectedAvatar ? Color.crimson : Color.green, lineWidth: 2)
                          )
                          .onTapGesture {
                              selectedAvatar = avatarName
                          }
                  }
              }
          }
  }
}

#Preview {
    let previewSelection: Binding<String> = Binding.constant("profile")
    return AvatarSelectionView(selectedAvatar: previewSelection)
}
