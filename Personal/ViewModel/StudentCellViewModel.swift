//
//  StudentCellViewModel.swift
//  Personal
//
//  Created by Tiago Braga on 8/6/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import Foundation

class StudentCellViewModel {
    
    var student: Student!
    
    var name: String {
        return self.student.first_name + " " + self.student.last_name
    }
    
    var detailLesson: String {
        guard let lesson = self.student.lesson else { return "" }
        return "\(lesson.weekDays) às \(lesson.hour)"
    }
    
    init(student: Student) {
        self.student = student
    }
    
}
