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
        let router = Router(navigationController: navigationController)
//        let listCoordinator = ListCoordinator(navigationController: navigationController)
        let listCoordinator = ListCoordinator(router: router)
        
        // store child coordinator
        self.store(coordinator: listCoordinator)
        listCoordinator.start()
        
        router.push(listCoordinator, isAnimated: true) { [weak self, weak listCoordinator] in
            guard let strongSelf = self, let listCoordinator = listCoordinator else { return }
            strongSelf.free(coordinator: listCoordinator)
        }
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // detect when free it
//        listCoordinator.isCompleted = { [weak self] in
//            self?.free(coordinator: listCoordinator)
//        }
    }
}
