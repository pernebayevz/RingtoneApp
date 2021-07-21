//
//  TabbarControllerViewController.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 13.07.2021.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: false)
        view.backgroundColor = .black
        
        let tab1 = RingtoneListViewController()
        tab1.tabBarItem.image = UIImage(named: "call")
        
        let tab2 = MainNavigationController(rootViewController: HomeViewController())
        tab2.tabBarItem.image = UIImage(named: "home")
        
        let tab3 = UIViewController()
        tab3.tabBarItem.image = UIImage(named: "live")
        
        let tab4 = UIViewController()
        tab4.tabBarItem.image = UIImage(named: "four_k")
        
        viewControllers = [tab1, tab2, tab3, tab4]
        
        tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.8)
        tabBar.backgroundColor = .black
        tabBar.barTintColor = .black
        
        let tabbarBgImage = UIImage(named: "bg_tabbar")
        let bgImageView = UIImageView(image: tabbarBgImage)
        tabBar.insertSubview(bgImageView, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
//            let vc = SwipeUpForMoreViewController()
//            vc.modalPresentationStyle = .overCurrentContext
//            vc.modalTransitionStyle = .crossDissolve
//            self.present(vc, animated: true, completion: nil)
//        }
    }
}
