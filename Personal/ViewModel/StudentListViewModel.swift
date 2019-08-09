//
//  StudentListViewModel.swift
//  Personal
//
//  Created by Tiago Braga on 7/29/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import Foundation

class StudentListViewModel {
    
    var reloadTableViewClosure: () -> () = {  }
    var didTappedStudent: (Student) -> () = { _ in }
    var didTappedNewStudent: () -> () = {  }
    var didTapBack: () -> () = {  }
    
    var hasContent: Dynamic<Bool> = Dynamic(false)
    var textNoDataWarning: String = "Nenhum aluno adicionado"
    var textNewUser: String = Localizable.string(forKey: "btn_add_new_user")
    var titlePage: String = Localizable.string(forKey: "title_list")
    
    private var cellStudentViewModels: [StudentCellViewModel] = [StudentCellViewModel]() {
        didSet {
            self.hasContent.value = self.numberOfCells > 0
            self.reloadTableViewClosure()
        }
    }
    
    var numberOfCells: Int {
        get {
            return self.cellStudentViewModels.count
        }
    }
    
    func fecthData() {
        self.cellStudentViewModels = Database.allStudents().map { StudentCellViewModel(student: $0) }
    }
    
    func getCellViewModel(row: Int) -> StudentCellViewModel {
        return self.cellStudentViewModels[row]
    }
    
    func makePresente(viewModel: StudentCellViewModel) {
        Database.newPresence(student: viewModel.student)
    }
    
}
