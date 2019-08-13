//
//  Lesson.swift
//  Personal
//
//  Created by Tiago Braga on 11/21/18.
//  Copyright © 2018 Physis. All rights reserved.
//

import RealmSwift
import Foundation

class Lesson: Object {
    @objc dynamic var id: String = NSUUID().uuidString.lowercased()
    let days = List<Int>()
    @objc dynamic var hour = "00:00"
    @objc dynamic var created_at = Date()
    @objc dynamic var updated_at = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Lesson {
    
    var weekDays: String {
        get {
            var calendar = Calendar(identifier: .gregorian)
            calendar.locale = Locale(identifier: "pt_BR")
            let shortWeekday = calendar.shortWeekdaySymbols
            let values = shortWeekday.filter { return Array(self.days).contains(shortWeekday.firstIndex(of: $0)!) }
            return values.map{ return $0.capitalizingFirstLetter() }.joined(separator: ", ")
        }
    }
    
}
