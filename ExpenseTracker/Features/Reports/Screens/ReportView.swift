//
//  ReportView.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 24/04/2024.
//

import SwiftUI
import Charts
struct ReportView: View {
    @EnvironmentObject var viewModel: ReportViewModel
    
    func onNotFiltering() {
        viewModel.expenseName = ""
        viewModel.category = "Food"
        viewModel.amount = ""
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
                    RemainingBalanceView()
                    FilterItemView()
                    ExpensesBottomSheetView()
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("Expenses").font(.title)
                                .bold()
                            Spacer()
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .onTapGesture {
                                    viewModel.isFiltering = true
                                }
                                .padding(.trailing)
                            Image(systemName: "plus.square")
                                .onTapGesture {
                                    viewModel.isCreating = true
                                    
                                }
                        }
                    }
            }
            }
        }
        .alert("Enter your balance", isPresented: $viewModel.isAddingBalance) {
            TextField("Balance", text: $viewModel.balance)
            Button("Add", role: .none) {
                if !viewModel.balance.isEmpty {
                    viewModel.updateBalance(amount: Int(viewModel.balance)!)
                    viewModel.isAddingBalance = false
                }
            }
        }
        .sheet(isPresented: $viewModel.isFiltering){
            FilterView()
        }
        .sheet(isPresented: $viewModel.isEditing, onDismiss: onNotFiltering){
            CreateEditExpenseView()
                .presentationDragIndicator(.automatic)
        }
        
        .sheet(isPresented: $viewModel.isCreating, onDismiss: onNotFiltering){
            CreateEditExpenseView()
                .presentationDragIndicator(.automatic)
        }.interactiveDismissDisabled()
            .task {
                viewModel.listenToExpenses()
                viewModel.listenToBalance()
            }
    }
}


#Preview {
    ReportView().environmentObject(ReportViewModel())
}



