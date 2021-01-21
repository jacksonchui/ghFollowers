//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Jackson Chui on 1/21/21.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM YYYY"
        return dateFormatter.string(from: self)
    }
}
