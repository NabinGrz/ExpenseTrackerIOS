//
//  ReportViewModel.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 24/04/2024.
//

import Foundation
import FirebaseFirestore
import SwiftUI
import Observation
import Combine

enum Filter {
    case none
    case today
    case weekly
    case twoWeeks
    case monthly
}

final class ReportViewModel: ObservableObject {
    let db = Firestore.firestore()
    @Published var filterBy: Filter = Filter.today
    @Published var expenses:  [Expense] = []
    @Published var filteredExpenses:  [Expense] = []
    @Published var selectedExpenseID: String? = nil
    @Published var selectedExpense: Expense? = nil
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    @Published var isFiltering: Bool = false
    @Published var isAddingBalance: Bool = false
    @Published var isEditing: Bool = false
    @Published var isCreating: Bool = false
    @Published var selectedTab: Int = 0
    @Published var chartData:  [ViewCategory] = []
    @Published var expenseName: String = ""
    @Published var category: String = "Food"
    @Published var amount: String = ""
    @Published var balance: String = ""

    
    @Published var fromDate: Date = Date()
    @Published var toDate: Date = Date()
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.fetchSearchResults(searchText)
            }
            .store(in: &cancellables)
    }
    
    func createDate(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        // Specify the calendar you want to use
        let calendar = Calendar.current
        
        // Create the date from the components
        return calendar.date(from: dateComponents)!
    }
    
    func fetchSearchResults(_ searchText: String) {
        if searchText.count >= 2 {
            self.filteredExpenses = filteredExpenses.filter { $0.expense_name.lowercased().contains(searchText.lowercased()) }
        }else{
            self.filteredExpenses = expenses
        }
    }
    
    var isValidExpense: Bool {
        guard !expenseName.isEmpty && !category.isEmpty && !amount.isEmpty else {
            return false
        }
        
        return true
    }
    
    func updateExpense(id: String, expense: Expense) {
        let docRef = db.collection("expenses").document(id)
        
        docRef.setData([
            "amount": expense.amount,
            "created_at": expense.created_at,
            "expense_categories": expense.expense_categories,
            "expense_name": expense.expense_name,
        ], merge: true){error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully merged!")
            }
        }
    }
    
    func deleteExpense(id: String) {
        let docRef = db.collection("expenses").document(id)
        docRef.delete()
    }
    
    func createExpense(expense: Expense) {
        // Create a document in the expenses collection
        db.collection("expenses").addDocument(data: [
            "amount": expense.amount,
            "created_at": expense.created_at,
            "expense_categories": expense.expense_categories,
            "expense_name": expense.expense_name,
        ])
    }  
    
    
    func listenToExpenses() {
        db.collection("expenses").addSnapshotListener { (snapshot, error) in
            if let snapshot = snapshot {
                self.filteredExpenses.removeAll()
                self.expenses.removeAll()
                self.chartData.removeAll()
                for document in snapshot.documents {
                    
                    let amount = document.data()["amount"] as? String
                    let createdAt = document.data()["created_at"] as? String
                    let category = document.data()["expense_categories"] as? String
                    let expenseName = document.data()["expense_name"] as? String
                    
                    let expense = Expense(id: document.documentID, amount: amount!, created_at: createdAt!, expense_categories: category!, expense_name: expenseName!)
                    self.expenses.append(expense)
                    self.filter(filterBy: self.filterBy, expense: expense)
                    
                }
                
                self.populateDataForChart()
            }
            
        }
        
    }  
    
    func listenToBalance() {
        let docRef = db.collection("balance").document("Xmn9HLlEI0iYbQaiqRM8")
        docRef.addSnapshotListener { (snapshot, error) in
            self.balance = "\(snapshot?.data()?["amount"] as? Int ?? 0)"
        }
        
    }

    
    func updateBalance(amount: Int) {
        let docRef = db.collection("balance").document("Xmn9HLlEI0iYbQaiqRM8")
        docRef.setData([
            "amount": amount,
        ], merge: true){error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully merged!")
            }
        }
    }
    
    func filter(filterBy: Filter, expense: Expense) {
        let createdDay = expense.created_at.toDate ?? Date()
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        var dateComponents = DateComponents()
        
        switch filterBy {
        case .none:
            self.filteredExpenses.append(expense)
        case .today:
            let components1 = calendar.dateComponents([.year, .month, .day], from: createdDay)
            let components2 = calendar.dateComponents([.year, .month, .day], from: today)
            
            if let year1 = components1.year, let year2 = components2.year,
               let month1 = components1.month, let month2 = components2.month,
               let day1 = components1.day, let day2 = components2.day {
                if year1 == year2 && month1 == month2 && day1 == day2 {
                    self.filteredExpenses.append(expense)
                   
                }
            }
        case .weekly:
            dateComponents.day = -7
            let oneWeekAgo = calendar.date(byAdding: dateComponents, to: today)!
            
            if createdDay > oneWeekAgo {
                self.filteredExpenses.append(expense)
            }
        case .twoWeeks:
            dateComponents.day = -14
            let twoWeeksAgo = calendar.date(byAdding: dateComponents, to: today)!
            
            if createdDay > twoWeeksAgo {
                self.filteredExpenses.append(expense)
            }
        case .monthly:
            dateComponents.day = -30
            let thirtyDaysAgo = calendar.date(byAdding: dateComponents, to: today)!
            
            if createdDay > thirtyDaysAgo {
                self.filteredExpenses.append(expense)
            }
        }
        
    }
    
    func populateDataForChart() {
        groupedExpenses().forEach { category, totalAmount in
            chartData.append(ViewCategory(category: category, viewCount: totalAmount))
        }
    }
    
    func groupedExpenses() -> [String: Int] {
        let groupedExpenses = Dictionary(grouping: filteredExpenses, by: { $0.expense_categories })
        return groupedExpenses.mapValues { $0.reduce(0) { $0 + Int($1.amount)! } }
    }
    struct ViewCategory: Identifiable {
        var id = UUID()
        var category: String
        var viewCount: Int
    }
}
