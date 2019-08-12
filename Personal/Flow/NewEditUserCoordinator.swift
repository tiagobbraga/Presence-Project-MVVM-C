//
//  NewEditUserCoordinator.swift
//  Personal
//
//  Created by Tiago Braga on 8/7/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import UIKit

class NewEditUserCoordinator: BaseCoordinator {
    
    var viewModel: StudentViewModel
    let router: RouterProtocol
    
    lazy var controller: NewEditUserViewController = {
        let newEdituserViewController = NewEditUserViewController.instantiate()
        newEdituserViewController.viewModel = self.viewModel
        return newEdituserViewController
    }()
    
    init(viewModel: StudentViewModel, router: RouterProtocol) {
        self.viewModel = viewModel
        self.router = router
    }
    
    override func start() {
        let newEdituserViewController = NewEditUserViewController.instantiate() 
        newEdituserViewController.setup(viewModel: self.viewModel)
    }

}

extension NewEditUserCoordinator: Drawable {
    
    var viewController: UIViewController? { return controller }
    
}
