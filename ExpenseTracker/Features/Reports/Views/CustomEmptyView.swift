//
//  CustomEmptyView.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 29/04/2024.
//

import SwiftUI

struct CustomEmptyView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("No Expenses")
                    .font(.callout)
                    .foregroundColor(.gray)
                Spacer()
            }
            Spacer()
        }
    }
}


#Preview {
    CustomEmptyView()
}
