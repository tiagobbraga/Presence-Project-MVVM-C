//
//  AddStudentViewModel.swift
//  Personal
//
//  Created by Tiago Braga on 8/7/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import Foundation

class AddStudentViewModel: StudentViewModel {
    
    var updatedStudent: (Student?) -> () = { _ in }
    var goBack: (() -> Void)? = {  }
    
    var title: String {
        return Localizable.string(forKey: "title_new_user")
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
            guard let date = date else { return }            
            hour.value = date.formatDate(format: "HH:mm")
            validateInput()
        }
    }
    
    var editableContent: Bool = false
    
    var hideContainerHour: Dynamic<Bool> = Dynamic(true)
    
    var validInputData: Dynamic<Bool> = Dynamic(false)
    
    // MARK: Methods
    func submitStudent() {
        guard let firstname = self.firstname,
            let lastname = self.lastname,
            let days = self.days
        else {
            return
        }
        
        Database.newStudent(firstname: firstname, lastname: lastname, hour: self.hour.value, days: days)
        self.goBack?()
    }
    
    func desactiveStudent() {}
    
    private func validateInput() {
        self.validInputData.value = false
        
        if let firstname = self.firstname, firstname.count > 0,
            let lastname = self.lastname, lastname.count > 0,
            let days = self.days, days.count > 0,
            self.hour.value.count > 0 {
            self.validInputData.value = true
        }
    }

}
