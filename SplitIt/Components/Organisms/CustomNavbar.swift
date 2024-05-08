//
//  CustomNavbarWithTitle.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 08/05/24.
//

import SwiftUI

struct CustomNavbar: View {
    var backButtonAction: (() -> Void)?
    
    var body: some View {
        HStack {
            if let action = backButtonAction {
                BackButton(action: action)
            }
            Spacer()
            HeaderTitle(first: "wealth", second: "OS")
                .kerning(2)
                .font(.largeTitle)
                .fontWeight(.thin)
            
            Spacer()
        }
    }
}

#Preview {
    CustomNavbar()
}
