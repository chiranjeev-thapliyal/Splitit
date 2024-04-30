//
//  TransactionRow.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 30/04/24.
//

import SwiftUI

struct TransactionRow: View {
    let payee: String
    let amount: Int
    let members: [String]
    let label: String
    let icon: String
    var isSystemIcon: Bool = false
    
    var share: Int {
        amount / (members.count + 1)
    }
    
    var remainingAmount: Int {
        amount - share
    }
    
    var body: some View {
        HStack(alignment: .center){
            HStack(alignment: .center, spacing: 16){
                CircularImage(width: 48, height: 48, strokeColor: Color.regularGreen, icon: icon, isSystemIcon: isSystemIcon)
                VStack(alignment: .leading) {
                    Text(label)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundStyle(Color.gray)
                    
                    Text("you paid AED \(amount)")
                        .font(.caption2)
                        .foregroundStyle(Color.gray)
                }
            }
            Spacer()
            VStack(alignment: .trailing){
                Text("AED \(remainingAmount)")
                    .font(.subheadline)
                    .foregroundStyle(Color.regularGreen)
                    .bold()
                    
                Text("you lent")
                    .font(.caption2)
                    .foregroundStyle(Color.gray)
            }
        }
    }
}

#Preview {
    let payee = "Chiranjeev"
    let amount = 400
    let members = ["Jaskaran", "Abhishek"]
    let label = "Movie"
    
    return TransactionRow(payee: payee, amount: amount, members: members, label: label, icon: "movieclapper.fill", isSystemIcon: true)
}
