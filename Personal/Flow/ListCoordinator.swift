//
//  MyCoordinator.swift
//  Personal
//
//  Created by Tiago Braga on 7/29/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import Foundation
import UIKit

class ListCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewModel: StudentListViewModel = StudentListViewModel()
        
        let listViewController = ListViewController.instantiate()
        listViewController.setup(viewModel: viewModel)
        
        viewModel.didTappedStudent = { [weak self] student in
            guard let strongSelf = self else { return }
            strongSelf.listPresence(viewModel: PresenceListViewModel(student: student), navigationController: strongSelf.navigationController)
        }
        
        viewModel.didTappedNewStudent = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.newEditUser(viewModel: AddStudentViewModel(), navigationController: strongSelf.navigationController)
        }
        
        self.navigationController.pushViewController(listViewController, animated: false)
    }
    
    private func listPresence(viewModel: PresenceListViewModel, navigationController: UINavigationController) {
        let listStudentCoordinator: ListPresenceCoordinator = ListPresenceCoordinator(viewModel: viewModel, navigationController: navigationController)
        self.store(coordinator: listStudentCoordinator)
        listStudentCoordinator.start()
        listStudentCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: listStudentCoordinator)
        }
    }
    
    private func newEditUser(viewModel: StudentViewModel?, navigationController: UINavigationController) {
        let newEditUserCoordinator: NewEditUserCoordinator = NewEditUserCoordinator(viewModel: viewModel, navigationController: navigationController)
        self.store(coordinator: newEditUserCoordinator)
        newEditUserCoordinator.start()
        newEditUserCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: newEditUserCoordinator)
        }        
    }
    
}
