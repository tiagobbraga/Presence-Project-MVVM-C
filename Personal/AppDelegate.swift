//
//  AppDelegate.swift
//  Personal
//
//  Created by Tiago Braga on 11/21/18.
//  Copyright © 2018 Physis. All rights reserved.
//

import UIKit
import RealmSwift
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Fabric.with([Crashlytics.self])
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        self.window = UIWindow()
        
        let appCoordinator = AppCoordinator(window: self.window!)
        appCoordinator.start()
        self.appCoordinator = appCoordinator
        
        return true
    }


}

