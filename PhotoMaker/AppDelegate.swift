//
//  AppDelegate.swift
//  PhotoMaker
//
//  Created by Dmitry Lapata on 23.08.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = self.window {
            let navigationController = UINavigationController()
            navigationController.viewControllers = [ViewController()]
            
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        
        return true
    }

    


}

