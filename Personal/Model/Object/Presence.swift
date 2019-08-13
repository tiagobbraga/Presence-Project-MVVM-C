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
