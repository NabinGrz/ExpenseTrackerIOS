//
//  Date+Ext.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 26/04/2024.
//

import Foundation


extension Date {
    
    var minusOneDay: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    }  
    var plusOneDay: Date {
        Calendar.current.date(byAdding: .day, value: +1, to: Date())!
    }
    
    var eighteenYearsAgo: Date {
        Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    }
    
    
    var oneHundredTenYearsAgo: Date {
        Calendar.current.date(byAdding: .year, value: -110, to: Date())!
    }
}
