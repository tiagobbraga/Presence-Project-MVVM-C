//
//  NewEditUserCoordinator.swift
//  Personal
//
//  Created by Tiago Braga on 8/7/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import UIKit

class NewEditUserCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    var viewModel: StudentViewModel?
    
    init(viewModel: StudentViewModel?, navigationController: UINavigationController) {
        self.viewModel = viewModel
        self.navigationController = navigationController
    }
    
    override func start() {
        let newEdituserViewController = NewEditUserViewController.instantiate() 
        newEdituserViewController.setup(viewModel: self.viewModel!)
        
        self.viewModel?.goBack = { [weak self] in
            self?.navigationController.popViewController(animated: true)
            self?.isCompleted?()
        }
        
        self.navigationController.pushViewController(newEdituserViewController, animated: true)
    }

}
