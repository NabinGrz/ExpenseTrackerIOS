//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 24/04/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ReportView()
            .environmentObject(ReportViewModel())
    }
}

#Preview {
    ContentView()
}
