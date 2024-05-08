//
//  CustomNavbarWithTitle.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 08/05/24.
//

import SwiftUI
struct CustomNavbar: View {
    
    var leftIcon: String?
    var leftIconAction: (() -> Void)?
    
    var rightIcon: String?
    var rightIconAction: (() -> Void)?
    
    var body: some View {
        HStack(alignment: .center) {
            if let action = leftIconAction, let icon = leftIcon {
                Button(action: action) {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.regularGreen)
                        .frame(width: 28, height: 28)
                }
            }

            Spacer()

            HeaderTitle(first: "wealth", second: "OS")
                .kerning(2)
                .font(.largeTitle)
                .fontWeight(.thin)

            Spacer()

            if let action = rightIconAction, let icon = rightIcon {
                Button(action: action){
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.regularGreen)
                        .frame(width: 28, height: 28)
                }
            }
        }
    }
}

#Preview {
    CustomNavbar(leftIconAction: {}, rightIconAction: {})
}
