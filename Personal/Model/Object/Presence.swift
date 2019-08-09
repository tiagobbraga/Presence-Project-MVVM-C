//
//  Presence.swift
//  Personal
//
//  Created by Tiago Braga on 11/21/18.
//  Copyright © 2018 Physis. All rights reserved.
//

import RealmSwift

class Presence: Object {
    @objc dynamic var id: String = NSUUID().uuidString.lowercased()
    @objc dynamic var date: Date = Date()
    
    convenience init(date: Date) {
        self.init()
        self.date = date
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Presence {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy - HH:mm"
        return formatter.string(from: self.date)
    }
    
    func formatMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self.date)
    }
}
