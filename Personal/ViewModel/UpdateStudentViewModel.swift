//
//  UpdateStudentViewModel.swift
//  Personal
//
//  Created by Tiago Braga on 8/7/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import Foundation

class UpdateStudentViewModel: StudentViewModel {
    
    var updatedStudent: ((Student?) -> Void) = { _ in  }
    var goBack: (() -> Void)? = {  }
    
    var title: String {
        return Localizable.string(forKey: "title_edit_user")
    }
    
    var firstname: String? {
        didSet {
            validateInput()
        }
    }
    
    var lastname: String? {
        didSet {
            validateInput()
        }
    }
    
    var days: IndexSet? {
        didSet {
            validateInput()
        }
    }
    
    var hour: Dynamic<String> = Dynamic("")
    
    var date: Date? {
        didSet {
            hour.value = UpdateStudentViewModel.hourFormatter.string(from: date!)
            validateInput()
        }
    }
    
    var editableContent: Bool = true
    
    var validInputData: Dynamic<Bool> = Dynamic(false)

    var hideContainerHour: Dynamic<Bool> = Dynamic(true)
    
    private static let hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    private var student: Student!
    
    
    // MARK: Methods
    func submitStudent() {
        guard let firstname = self.firstname,
            let lastname = self.lastname,
            let days = self.days else {
            return
        }
        
        Database.updateStudent(id: self.student.id, firstname: firstname, lastname: lastname, hour: self.hour.value, days: days)
        self.updatedStudent(self.student)
    }
    
    func desactiveStudent() {
        Database.desactiveStudent(id: self.student.id)
        self.updatedStudent(self.student)
    }
    
    init(student: Student) {
        self.student = student
        
        self.firstname = student.first_name
        self.lastname = student.last_name
        
        if let lesson = student.lesson {
            self.days = IndexSet.init(Array(lesson.days))
            self.hour.value =  lesson.hour
        }
        
        self.validateInput()
    }
    
    private func validateInput() {
        self.validInputData.value = false
        
        if let firstname = self.firstname, firstname.count > 0,
            let lastname = self.lastname, lastname.count > 0,
            let days = self.days, days.count > 0,
            self.hour.value.count > 0 {
            self.validInputData.value = true
        }
        
//        print("validInputData.value \(validInputData.value)")
    }
    

}
