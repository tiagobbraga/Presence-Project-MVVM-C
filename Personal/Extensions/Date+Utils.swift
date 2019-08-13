//
//  Date+Utils.swift
//  Personal
//
//  Created by Tiago Braga on 7/30/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import Foundation

extension Date {
    func hasSame(_ components: Calendar.Component..., as date: Date, using calendar: Calendar = .autoupdatingCurrent) -> Bool {
        return components.filter { calendar.component($0, from: date) != calendar.component($0, from: self) }.isEmpty
    }
    
    func formatDate(format: String = "MMM d, yyyy - HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
