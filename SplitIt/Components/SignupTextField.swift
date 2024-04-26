//
//  SignupTextField.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 09/04/24.
//

import SwiftUI

struct SignupTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: icon).foregroundColor(.gray).padding(.leading, 10)
            Divider().frame(height: 10).background(.gray)
            if isSecure {
                SecureField(placeholder, text: $text).padding(.leading, 10)
            } else {
                TextField(placeholder, text: $text).padding(.leading, 10)
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 50))
        
    }
}

#Preview {
    @State var fullName: String = ""
    return SignupTextField(icon: "person", placeholder: "Full Name", text: $fullName, isSecure: true)
}
