//
//  HomeViewController.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 15.07.2021.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var settingsBtn: UIBarButtonItem = {[unowned self] in
        let btn = UIButton()
        btn.setImage(UIImage(named: "gear"), for: .normal)
        btn.addTarget(self, action: #selector(settingsBtnTapHandler(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }()
    lazy var crownBtn: UIBarButtonItem = {[unowned self] in
        let btn = UIButton()
        btn.setImage(UIImage(named: "crown2"), for: .normal)
        btn.addTarget(self, action: #selector(crownBtnTapHandler(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Collection"
        navigationItem.leftBarButtonItem = settingsBtn
        navigationItem.rightBarButtonItem = crownBtn
    }
    
    private func setupView() {
        
    }
    
    @objc private func settingsBtnTapHandler(_ sender: UIButton) {
        
    }
    
    @objc private func crownBtnTapHandler(_ sender: UIButton) {
        let subscriptionVC = SubscriptionViewController()
        navigationController?.pushViewController(subscriptionVC, animated: true)
    }
}
