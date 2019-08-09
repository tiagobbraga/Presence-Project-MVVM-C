//
//  Database.swift
//  Personal
//
//  Created by Tiago Braga on 7/29/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import Foundation
import RealmSwift

class Database {
    
    static func allStudents() -> Array<Student> {
        let realm = try! Realm()
        let students = realm.objects(Student.self)
        return Array(students)
    }
    
    static func allStudentsActive() -> Array<Student> {
        let realm = try! Realm()
        let students = realm.objects(Student.self).filter("active = %@", true)
        return Array(students)
    }
    
    static func newPresence(student: Student) {
        let realm = try! Realm()
        try! realm.write {
            let presence = Presence(date: Date())
            student.presences.append(presence)
        }
    }
    
    static func newStudent(firstname: String, lastname: String, hour: String, days: IndexSet) {
        let realm = try! Realm()
        try! realm.write {
            let lesson = Lesson()
            days.sorted().forEach({ (day) in
                lesson.days.append(day)
            })
            lesson.hour = hour
            
            let student = Student()
            student.first_name = firstname
            student.last_name = lastname
            student.lesson = lesson
            
            realm.add(student)
        }
    }
    
    static func updateStudent(id: String, firstname: String, lastname: String, hour: String, days: IndexSet) {
        let realm = try! Realm()
        if let student: Student = realm.object(ofType: Student.self, forPrimaryKey: id) {
            try! realm.write {
                if let lesson = student.lesson {
                    lesson.days.removeAll()
                    days.sorted().forEach({ (day) in
                        lesson.days.append(day)
                    })
                    lesson.hour = hour
                    lesson.updated_at = Date()
                }
                
                student.first_name = firstname
                student.last_name = lastname
                student.updated_at = Date()
            }
        }
    }
    
    static func desactiveStudent(id: String) {
        let realm = try! Realm()
        if let student: Student = realm.object(ofType: Student.self, forPrimaryKey: id) {            
            try! realm.write {
                student.active = false
            }
        }
    }

}
