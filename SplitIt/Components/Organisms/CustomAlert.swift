//
//  CustomAlert.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 15/05/24.
//


import SwiftUI

struct CustomAlert: View {
    var title: String
    var message: String
    var primaryButtonText: String
    var secondaryButtonText: String
    var primaryButtonAction: () -> Void
    var secondaryButtonAction: () -> Void

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding(.top, 10)
            
            Text(message)
                .font(.body)
                .padding(.vertical, 10)
                .multilineTextAlignment(.center)

            Divider()

            HStack {
                Button(action: secondaryButtonAction) {
                    Text(secondaryButtonText)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                    .frame(height: 20)
                
                Button(action: primaryButtonAction) {
                    Text(primaryButtonText)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .frame(width: 300, height: 150)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}



#Preview {
    CustomAlert(
        title: "Error",
        message: "Please confirm that you're still open to session requests",
        primaryButtonText: "Go",
        secondaryButtonText: "Cancel",
        primaryButtonAction: {
//                            showAlert = false
        },
        secondaryButtonAction: {
            // Handle secondary action
//                            showAlert = false
        }
    )
}
