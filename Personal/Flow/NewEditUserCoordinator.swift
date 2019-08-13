//
//  NewEditUserCoordinator.swift
//  Personal
//
//  Created by Tiago Braga on 8/7/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import UIKit

class NewEditUserCoordinator: BaseCoordinator {
    
    let router: RouterProtocol
    
    lazy var controller: NewEditUserViewController = {
        let newEdituserViewController = NewEditUserViewController.instantiate()
        return newEdituserViewController
    }()
    
    init(viewModel: StudentViewModel, router: RouterProtocol) {
        self.router = router
        super.init()
        self.controller.viewModel = viewModel
    }
    
    override func start() {
        self.controller.viewModel?.goBack = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.router.pop(true)
        }
        
        self.controller.viewModel?.updatedStudent = { [weak self] student in
            guard let strongSelf = self else { return }
            strongSelf.router.popToRoot(true)
        }
    }

}

extension NewEditUserCoordinator: Drawable {
    
    var viewController: UIViewController? { return controller }
    
}
