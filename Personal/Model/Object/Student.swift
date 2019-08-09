//
//  Student.swift
//  Personal
//
//  Created by Tiago Braga on 11/21/18.
//  Copyright © 2018 Physis. All rights reserved.
//

import RealmSwift

class Student: Object {
    @objc dynamic var id: String = NSUUID().uuidString.lowercased()
    @objc dynamic var first_name = ""
    @objc dynamic var last_name = ""
    @objc dynamic var active = true
    @objc dynamic var lesson: Lesson? = nil
    let presences = List<Presence>()
    @objc dynamic var created_at = Date() 
    @objc dynamic var updated_at = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
