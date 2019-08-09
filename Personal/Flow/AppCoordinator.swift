//
//  AppCoordinator.swift
//  Personal
//
//  Created by Tiago Braga on 7/29/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator : BaseCoordinator {
    
    let window : UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    override func start() {
        // preparing root view
        let navigationController = UINavigationController()
        let listCoordinator = ListCoordinator(navigationController: navigationController)
        
        // store child coordinator
        self.store(coordinator: listCoordinator)
        listCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // detect when free it
        listCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: listCoordinator)
        }
    }
}
