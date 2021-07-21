//
//  MainNavigationController.swift
//  MainNavigationController
//
//  Created by Zhangali Pernebayev on 20.07.2021.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customize()
    }
    
    private func customize() {
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        delegate = self
    }
}

extension MainNavigationController: UINavigationControllerDelegate {
    
}
