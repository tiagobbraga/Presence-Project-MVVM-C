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
    
    func transcriptFormatDays() -> String {
        var transcript: [String] = []
        self.days.forEach { (day) in
            switch day {
            case 0:
                transcript.append("Seg")
            case 1:
                transcript.append("Ter")
            case 2:
                transcript.append("Qua")
            case 3:
                transcript.append("Qui")
            case 4:
                transcript.append("Sex")
            case 5:
                transcript.append("Sáb")
            default:
                transcript.append("Dom")
            }
        }
        return transcript.joined(separator: ", ")
    }
    
}
