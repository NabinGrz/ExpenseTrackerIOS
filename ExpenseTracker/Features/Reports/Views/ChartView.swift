//
//  ChartView.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 29/04/2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    @EnvironmentObject var viewModel: ReportViewModel
    
    var body: some View {
        if viewModel.filteredExpenses.isEmpty {
            CustomEmptyView()
        }else {
            Chart{
                ForEach(viewModel.chartData) {exp in
                    BarMark(
                        x: .value("Category", exp.category),
                        y: .value("Amount", exp.viewCount))
                    .foregroundStyle(by: .value("Category", exp.category))
                    .annotation {
                        Text("\(exp.viewCount)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                    }
                }
            }
            .chartLegend(.hidden)
            .chartYAxis(.hidden)
            .padding(.horizontal)
            .frame(height: 400)
        }
    }
}
#Preview {
    ChartView()
        .environmentObject(ReportViewModel())
}
