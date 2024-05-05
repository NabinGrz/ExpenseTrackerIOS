//
//  ExpenseItemView.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 24/04/2024.
//

import SwiftUI

struct ExpenseItemView: View {
    @EnvironmentObject var viewModel: ReportViewModel
    
    var body: some View {
        if viewModel.filteredExpenses.isEmpty {
            CustomEmptyView()
//            ItemCardView(image: "food", color: .red, expense: Expense.default)
        }
        else {
            VStack(alignment : .leading) {
                //                List {
                ForEach(viewModel.filteredExpenses) {expense in
                    let image = "\(PickImage().get(category: expense.expense_categories).image)"
                    let color = PickImage().get(category: expense.expense_categories).color.opacity(0.4)
                    ItemCardView(image: image, color: color, expense: expense)
                        .padding(.bottom, 2)
                        .listRowInsets(.init())
                        .onLongPressGesture(minimumDuration: 1){
                            if  let toDelete = viewModel.filteredExpenses.first(where: {$0.id == expense.id})
                            {
                                viewModel.deleteExpense(id: toDelete.id!)
                                viewModel.updateBalance(amount: Int(viewModel.balance)! + Int(toDelete.amount)!)
                            }
                        }
                    
                }
                Spacer()
            }
            .padding(.horizontal)
            
        }
        
        
    }
    
    func delete(at offsets: IndexSet){
        if let index = offsets.first {
            let expense = viewModel.filteredExpenses[index]
            viewModel.deleteExpense(id: expense.id!)
        }
    }
}


#Preview {
    ExpenseItemView()
        .environmentObject(ReportViewModel())
}

struct ItemCardView: View {
    let image: String
    let color: Color
    let expense: Expense
    @EnvironmentObject var viewModel: ReportViewModel
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .padding(5)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.trailing, 12)
            VStack(alignment: .leading) {
                Text(expense.expense_name)
                    .font(.system(size: 18))
                
                Text(expense.expense_categories)
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
            }
            Spacer()
            Text("- Rs \(expense.amount)")
                .foregroundColor(.red)
                .font(.system(size: 16))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("main").opacity(0.1))
        .cornerRadius(12)
        .onTapGesture(count: 2) {
            viewModel.selectedExpenseID = expense.id
            viewModel.selectedExpense = expense
            viewModel.isEditing = true
            viewModel.expenseName = expense.expense_name
            viewModel.category = expense.expense_categories
            viewModel.amount = expense.amount
            
        }
    }
}

