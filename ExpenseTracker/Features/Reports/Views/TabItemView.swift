//
//  TabItemView.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 24/04/2024.
//

import SwiftUI

struct TabItemView: View {
    let name: String
    let index : Int
    @EnvironmentObject var viewModel: ReportViewModel

    
    var body: some View {
        VStack {

            Text(name)
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
            if viewModel.selectedTab == index {
                Color("main")
                    .frame(height: 3)
            }else{
                Color("lightGray")
                    .frame(height: 3)
            }
            
        }
//        .onTapGesture {
//            withAnimation(.easeInOut(duration: 0.2)){
//                viewModel.selectedTab = index
//            }
//            
//        }
    }
}

#Preview {
    TabItemView(name: "Analytics", index: 0)
        .environmentObject(ReportViewModel())
}
