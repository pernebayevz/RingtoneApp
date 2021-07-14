//
//  AppDelegate.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 13.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        let rootViewcontroller = LaunchScreenViewController(animationCompletionBlock: { [unowned window] _ in
            let rootViewController = TabbarController()
            window?.rootViewController = rootViewController
            window?.makeKeyAndVisible()
        })
        window?.rootViewController = rootViewcontroller
        window?.makeKeyAndVisible()
        return true
    }
}
