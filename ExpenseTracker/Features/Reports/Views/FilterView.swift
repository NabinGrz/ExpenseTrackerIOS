//
//  FilterView.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 27/04/2024.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var viewModel: ReportViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("FILTER")
                    .font(.title2)
                Spacer()
                Image(systemName:  "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        viewModel.isFiltering = false
                    }
            }
            .padding(.bottom, 10)
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("From Date")
                    DatePicker("",selection: $viewModel.fromDate,in: Date().eighteenYearsAgo...Date(), displayedComponents: .date)
                        .labelsHidden()
                    
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("To Date")
                    DatePicker("",selection: $viewModel.toDate,in: viewModel.fromDate.eighteenYearsAgo...viewModel.fromDate.plusOneDay, displayedComponents: .date)
                        .labelsHidden()
                    
                }
            }
            Spacer()
            Button {
                let val =  viewModel.expenses.filter{
                    let calendar = Calendar.current
                    let date = $0.created_at.toDate ?? Date()
                    let range = viewModel.fromDate...viewModel.toDate
                    
                    let withinRange: Bool = range.contains(date)
                    return withinRange
                }
                
                viewModel.filteredExpenses = val
                viewModel.isFiltering = false
                viewModel.filterBy = Filter.none
            } label: {
                Text("Apply")
                    .bold()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            
        }
        .padding()
        .presentationDetents([.height(230)])
        .presentationDragIndicator(.visible)
        .padding(.vertical)
        .presentationDetents([.fraction(0.8), .medium, .large])
        .presentationDragIndicator(.hidden)
        .interactiveDismissDisabled()
    }
}


#Preview {
    FilterView()
        .environmentObject(ReportViewModel())
}
