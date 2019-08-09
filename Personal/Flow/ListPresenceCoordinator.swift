//
//  ListPresenceCoordinator.swift
//  Personal
//
//  Created by Tiago Braga on 7/30/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import Foundation
import UIKit

class ListPresenceCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    
    private var presenceListViewModel: PresenceListViewModel?
    
    init(viewModel: PresenceListViewModel?, navigationController: UINavigationController) {
        self.presenceListViewModel = viewModel
        self.navigationController = navigationController
    }
    
    override func start() {
        let listPresenceViewController = ListPresenceViewController.instantiate()
        listPresenceViewController.setup(viewModel: self.presenceListViewModel!)
        
        self.presenceListViewModel?.goBack = { [weak self] in
            self?.navigationController.popViewController(animated: true)
            self?.isCompleted?()
        }
        
        self.presenceListViewModel?.didTappedEditStudent = { [weak self] viewModel in
            guard let strongSelf = self else { return }
            strongSelf.newEditUser(viewModel: viewModel, navigationController: strongSelf.navigationController)
        }
        
        self.navigationController.pushViewController(listPresenceViewController, animated: true)
    }
    
    private func newEditUser(viewModel: StudentViewModel, navigationController: UINavigationController) {
        let newEditUserCoordinator: NewEditUserCoordinator = NewEditUserCoordinator(viewModel: viewModel, navigationController: navigationController)        
        self.store(coordinator: newEditUserCoordinator)
        newEditUserCoordinator.start()
        newEditUserCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: newEditUserCoordinator)
        }
    }
    
}
