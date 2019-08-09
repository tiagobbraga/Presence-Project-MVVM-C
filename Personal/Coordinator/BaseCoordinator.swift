//
//  BaseCoordinator.swift
//  Personal
//
//  Created by Tiago Braga on 7/29/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import Foundation

class BaseCoordinator : Coordinator {
    var childCoordinators : [Coordinator] = []
    var isCompleted: (() -> ())?
    
    func start() {
        fatalError("Children should implement `start`.")
    }
}
