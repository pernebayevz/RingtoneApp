//
//  SubscriptionViewController.swift
//  SubscriptionViewController
//
//  Created by Zhangali Pernebayev on 20.07.2021.
//

import UIKit

class SubscriptionViewController: UIViewController {

    @IBOutlet weak var subscriptionView: SubscriptionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        subscriptionView.delegate = self
    }
}

extension SubscriptionViewController: SubscriptionViewDelegate {
    func didTapShowMoreOptions() {
        
    }
    
    func didTapTermsOfUse() {
        
    }
    
    func didTapPrivacyPolicy() {
        
    }
    
    func didTapRestore() {
        
    }
    
    func didTapContinue() {
        
    }
    
    
}
