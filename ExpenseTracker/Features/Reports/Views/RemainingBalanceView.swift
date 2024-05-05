//
//  RemainingBalanceView.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 29/04/2024.
//

import SwiftUI

struct RemainingBalanceView: View {
    @EnvironmentObject var viewModel: ReportViewModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Remaining balance")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.bottom, 2)
                Text("Rs \(viewModel.balance)")
                    .font(.system(size: 35))
                    .bold()
                    .foregroundColor(.white)
            }
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(Color("main"))
        .cornerRadius(8)
        .padding(.horizontal)
        .padding(.bottom, 20)
        .onTapGesture {
            viewModel.isAddingBalance = true
        }
    }
}


#Preview {
    RemainingBalanceView()
        .environmentObject(ReportViewModel())
}
