//
//  HomeViewController.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 15.07.2021.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {

    @IBOutlet weak var playerView: PlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}
