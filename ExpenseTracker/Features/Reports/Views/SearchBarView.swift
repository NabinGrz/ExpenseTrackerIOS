//
//  SearchBarView.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 24/04/2024.
//

import SwiftUI

public actor Debouncer {
    private let duration: Duration
    private var isPending = false
    
    public init(duration: Duration) {
        self.duration = duration
    }
    
    public func sleep() async -> Bool {
        if isPending { return false }
        isPending = true
        try? await Task.sleep(for: duration)
        isPending = false
        return true
    }
}

struct SearchBarView: View {
    @EnvironmentObject var viewModel: ReportViewModel
    private let debouncer = Debouncer(duration: .seconds(0.5))
    
    
    
    var body: some View {
        HStack {
            TextField("Search ...", text: $viewModel.searchText)
                .padding(12)
                .padding(.vertical, 3)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                .onTapGesture {
                    viewModel.isSearching = true
                }
            if  viewModel.isSearching {
                Button(action: {
                    viewModel.isSearching = false
                    viewModel.searchText = ""
                    
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
        .overlay {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 24)
        }
    }
}

#Preview {
    SearchBarView().environmentObject(ReportViewModel())
    
}
