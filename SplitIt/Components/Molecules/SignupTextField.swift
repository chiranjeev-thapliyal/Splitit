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
    var keyboardType: UIKeyboardType = .default
    var onCommit: (() -> Void)? = nil
    var onChange: ((String) -> Void)? = nil
    
    var errorMessage: String = ""
    @Binding var text: String
    
    var isSecure: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Spacer()
                Image(systemName: icon).foregroundColor(.gray).padding(.leading, 10)
                Divider().frame(height: 10).background(.gray)
                
                if isSecure {
                    SecureField(placeholder, text: $text, onCommit: onCommit ?? {})
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .keyboardType(keyboardType)
                        .onChange(of: text, perform: { newValue in
                            onChange?(newValue)
                        })
                        .padding(.leading, 10)
                } else {
                    TextField(placeholder, text: $text, onCommit: onCommit ?? {})
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .kerning(1)
                        .keyboardType(keyboardType)
                        .onChange(of: text, perform: { newValue in
                            onChange?(newValue)
                        })
                        .padding(.leading, 10)
                }
                
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .foregroundStyle(.black)
            .background(colorScheme == .dark ? .black : .white)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(Color.crimson)
                    .bold()
                    .padding(.horizontal, 8)
            }
        }
//        .padding(.horizontal)
    }
}

#Preview {
    @State var fullName: String = "Chiranjeev"
    return  ZStack {
        Color.darkGreen
        SignupTextField(icon: "person", placeholder: "Full Name", keyboardType: .numberPad, text: $fullName)
    }
    
    
}
