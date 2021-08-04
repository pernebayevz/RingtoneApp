//
//  AppDelegate.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 13.07.2021.
//

import UIKit
import Lottie

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if window == nil {
            // set new UIWindow instance if window is nil
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        let rootVC = UINavigationController()
        rootVC.setNavigationBarHidden(true, animated: false)
        let launchScreenVC = LaunchScreenViewController {[unowned rootVC] in
            let onboardingVC = OnBoardingViewController()
            onboardingVC.onExit = {[unowned rootVC] in
                rootVC.setViewControllers([TabbarController()], animated: false)
            }
            rootVC.setViewControllers([onboardingVC], animated: false)
        }
        rootVC.viewControllers = [launchScreenVC]

        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }
}

