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
    
    let router: RouterProtocol
    init(router: RouterProtocol) {
        self.router = router
    }
    
    lazy var controller: ListViewController = {
        let listViewController = ListViewController.instantiate()
        let viewModel: StudentListViewModel = StudentListViewModel()
        listViewController.viewModel = viewModel
        return listViewController
    }()
    
    override func start() {
        self.controller.viewModel.didTappedStudent = { [weak self] student in
            guard let strongSelf = self else { return }
            strongSelf.listPresence(viewModel: PresenceListViewModel(student: student))
        }
        
        self.controller.viewModel.didTappedNewStudent = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.newEditUser()
        }
    }
    
    private func listPresence(viewModel: PresenceListViewModel) {
        let listStudentCoordinator: ListPresenceCoordinator = ListPresenceCoordinator(viewModel: viewModel, router: self.router)
        self.store(coordinator: listStudentCoordinator)
        listStudentCoordinator.start()
        self.router.push(listStudentCoordinator, isAnimated: true) { [weak self, weak listStudentCoordinator] in
            guard let strongSelf = self, let listStudentCoordinator = listStudentCoordinator else { return }
            strongSelf.free(coordinator: listStudentCoordinator)
        }
    }
    
    private func newEditUser() {
        let newEditUserCoordinator: NewEditUserCoordinator = NewEditUserCoordinator(router: self.router)
        self.store(coordinator: newEditUserCoordinator)
        newEditUserCoordinator.start()
        self.router.push(newEditUserCoordinator, isAnimated: true) { [weak self, weak newEditUserCoordinator] in
            guard let strongSelf = self, let newEditUserCoordinator = newEditUserCoordinator else { return }
            strongSelf.free(coordinator: newEditUserCoordinator)
        }
    }
    
}

extension ListCoordinator: Drawable {
    var viewController: UIViewController? { return controller }
}
