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
    
//    var navigationController: UINavigationController
    
    lazy var controller: ListPresenceViewController = {
        let listPresenceViewController = ListPresenceViewController.instantiate()
        listPresenceViewController.viewModel = self.presenceListViewModel
        return listPresenceViewController
    }()
    
    private var presenceListViewModel: PresenceListViewModel
    
    let router: RouterProtocol
    
    init(viewModel: PresenceListViewModel, router: RouterProtocol) {
        self.presenceListViewModel = viewModel
        self.router = router
    }
    
    override func start() {
        self.presenceListViewModel.didTappedEditStudent = { [weak self] viewModel in
            guard let strongSelf = self else { return }
            strongSelf.newEditUser(viewModel: viewModel)
        }
    }
    
    private func newEditUser(viewModel: StudentViewModel) {
        let newEditUserCoordinator: NewEditUserCoordinator = NewEditUserCoordinator(viewModel: viewModel, router: self.router)
        self.store(coordinator: newEditUserCoordinator)
        newEditUserCoordinator.start()
        self.router.push(newEditUserCoordinator, isAnimated: true) { [weak self, weak newEditUserCoordinator] in
            guard let strongSelf = self, let newEditUserCoordinator = newEditUserCoordinator else { return }
            strongSelf.free(coordinator: newEditUserCoordinator)
        }
    }
    
}

extension ListPresenceCoordinator: Drawable {
    var viewController: UIViewController? { return controller }
}
