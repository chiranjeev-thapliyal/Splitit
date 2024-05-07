//
//  HeaderTitle.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 29/04/24.
//

import SwiftUI

struct HeaderTitle: View {
    let first: String
    let second: String
    
    var body: some View {
        HStack(spacing: 0){
            Text(first).foregroundColor(.darkGreen)
            Text(second).foregroundColor(.gray)
        }
    }
}
#Preview {
    HeaderTitle(first: "wealth", second: "OS")
}
