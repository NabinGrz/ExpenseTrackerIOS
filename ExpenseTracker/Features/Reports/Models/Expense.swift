//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 24/04/2024.
//

import Foundation

struct Expense: Identifiable {
    let id: String?
    let amount: String
    let created_at: String
    let expense_categories: String
    let expense_name: String
    
    static let `default` =  Expense(id: "008leROjIMxUN5mof4BX", amount: "353", created_at: "2024-04-25 01:59:00 +0000"
                                    , expense_categories: "Grocey", expense_name: "Garlic")
}
