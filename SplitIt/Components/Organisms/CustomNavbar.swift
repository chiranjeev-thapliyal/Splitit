//
//  CustomNavbarWithTitle.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 08/05/24.
//

import SwiftUI

struct CustomNavbar: View {
    var leftIconAction: (() -> Void)?
    var rightIconAction: (() -> Void)?
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            if let action = leftIconAction {
                BackButton(action: action)
            }
            Spacer()
            HeaderTitle(first: "wealth", second: "OS")
                .kerning(2)
                .font(.largeTitle)
                .fontWeight(.thin)
            
            Spacer()
            
            if let action = rightIconAction {
                Button(action: action){
                    Image(systemName: "power")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.regularGreen)
                }
                .frame(width: 28, height: 28, alignment: .centerLastTextBaseline)
            }
        }
    }
}

#Preview {
    CustomNavbar(leftIconAction: {}, rightIconAction: {})
}
