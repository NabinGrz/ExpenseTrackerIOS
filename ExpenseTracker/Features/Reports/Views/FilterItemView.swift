//
//  FilterItemView.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 25/04/2024.
//

import SwiftUI


struct FilterItemView: View {
    
    @EnvironmentObject var viewModel: ReportViewModel
    var body: some View {

            HStack(spacing: 20) {
                Item(name: "Today", filterBy: Filter.today)
                Item(name: "Weekly", filterBy: Filter.weekly)
                Item(name: "2 Weeks", filterBy: Filter.twoWeeks)
                Item(name: "Monthly", filterBy: Filter.monthly)
            }
            .padding(2)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .background(Color("lightGray"))
            .cornerRadius(8)

        .padding(.horizontal)
    }
}

struct Item: View {
    let name: String
    let filterBy: Filter
    
    @EnvironmentObject var viewModel: ReportViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text(name)
            .font(.system(size: 15))
            .foregroundColor(colorScheme == .light &&  viewModel.filterBy != filterBy ? .black : .white)
            .onTapGesture {
                viewModel.filterBy = filterBy
                viewModel.listenToExpenses()
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 10)
            .background(viewModel.filterBy == filterBy ? Color("main") : Color("lightGray"))
            .cornerRadius(8)
    }
}

#Preview {
    FilterItemView()
        .environmentObject(ReportViewModel())
}
