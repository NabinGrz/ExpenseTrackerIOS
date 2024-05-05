//
//  String+Ext.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 25/04/2024.
//

import Foundation

extension String {
    var toDate : Date? {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
        dateFormatter.dateFormat = "yyyy-MM-dd h:mm:ss a Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let t = dateFormatter.date(from: self);
        return t
    }
    //"2023-05-07 00:00:00.00000Z"
    var format : String? {
        return self.toDate?.formatted(date: .abbreviated, time: .omitted)
    }
}
