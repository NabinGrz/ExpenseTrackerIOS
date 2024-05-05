//
//  CreateExpenseView.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 25/04/2024.
//

import SwiftUI

struct CreateEditExpenseView: View {
    
    @EnvironmentObject var viewModel: ReportViewModel
    let categories = [
        "Food",
        "Personal" ,
        "Water" ,
        "⺟ther" ,
        "Clothing" ,
        "Cosmetic" ,
        "Utils" ,
        "Bike" ,
        "Transport" ,
        "Khaja" ,
        "Chocolate",
        "Meat",
        "Milk",
        "Jhyapli Khaja",
        "Grocery",
        "Sugar",
        "Snacks",
        "Fruits",
        "Stationary",
        "Icecream",
        "Drink",
        "Gas",
        "Office Khaja" ,
        "Tomato",
        "Chamal",
        "Medicine",
        "Shampoo",
        "Petrol",
        "Dhaniya"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Form{
                    TextField("Chocolate", text: $viewModel.expenseName)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                    Picker("Select category", selection: $viewModel.category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    TextField("Amount", text: $viewModel.amount)
                        .keyboardType(.numberPad)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                    
                    
                }
                Button{
                    if viewModel.isValidExpense {
                        let val = Expense(id: nil, amount: viewModel.amount, created_at: "\(Date())", expense_categories: viewModel.category, expense_name: viewModel.expenseName)
                        if viewModel.isCreating {
                            viewModel.createExpense(expense: val)
                            viewModel.updateBalance(amount: Int(viewModel.balance)! - Int(val.amount)!)
                        }else {
                           
                            let newbalance = (Int(viewModel.balance)! + Int(viewModel.selectedExpense!.amount)!) - Int(viewModel.amount)!
                            viewModel.updateExpense(id: viewModel.selectedExpenseID!, expense: val)
                            viewModel.updateBalance(amount: newbalance)
                        }
                      
                        viewModel.isCreating = false
                        viewModel.isEditing = false
                       
                    }
                } label: {
                    Text(viewModel.isEditing ? "Update": "Create")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .toolbar(content: {
                    ToolbarItem {
                        Button {
                            viewModel.isCreating = false
                            viewModel.isEditing = false
                            viewModel.expenseName = ""
                            viewModel.category = "Food"
                            viewModel.amount = ""
                            
                        } label: {
                            Label("Dismiss", systemImage: "xmark.circle.fill")
                        }
                        
                    }
                })
            }
        }
        
    }
}

#Preview {
    CreateEditExpenseView()
        .environmentObject(ReportViewModel())
}
