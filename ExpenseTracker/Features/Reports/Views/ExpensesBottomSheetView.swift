//
//  ExpensesBottomSheetView.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 29/04/2024.
//

import SwiftUI
import Charts

struct ExpensesBottomSheetView: View {
    @EnvironmentObject var viewModel: ReportViewModel
    
    var body: some View {
        VStack(alignment : .leading) {
            let totalAmount = viewModel.filteredExpenses.reduce(0) {
                $0 + Int($1.amount)!
            }
            let title = viewModel.selectedTab == 0 ? "Expense List" : "Expense Chart"
            VStack(alignment : .leading) {
                Text(title)
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
                    .padding(.bottom, 4)
                Text("Total Expense Amount: Rs \(totalAmount)".trimmingCharacters(in: .whitespacesAndNewlines))
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            if viewModel.selectedTab == 0{
                SearchBarView()
                    .padding(.bottom, 28)
            }
            
            HStack {
                TabItemView(name: "Expenses", index: 0)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)){
                            viewModel.selectedTab = 0
                        }
                        
                    }
                Spacer()
                TabItemView(name: "Analytics", index: 1)
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.5)){
                            viewModel.selectedTab = 1
                        }
                        
                    }
            }
            .padding(.top)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .background(Color("lightGray"))
            .cornerRadius(8)
            .padding(.horizontal)
            .padding(.bottom)
            ZStack {
                if viewModel.selectedTab == 0{
                    ExpenseItemView()
                }else{
                    ChartView()
                }
            }
            .presentationDetents([.fraction(0.6), .large])
            .presentationDragIndicator(.hidden)
            .interactiveDismissDisabled()
            .presentationCornerRadius(24)
            .presentationBackgroundInteraction(.enabled(upThrough:.large))
        }
        .padding(.vertical, 20)
    }
}


#Preview {
    ExpensesBottomSheetView()
        .environmentObject(ReportViewModel())
}


