//
//  SubscriptionViewController.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 16.07.2021.
//

import UIKit

class SubscriptionViewController: UIViewController {

    @IBOutlet weak var showMoreOptions: UIButton!
    @IBOutlet weak var playerView: PlayerView!
    weak var delegate: OnBoardingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
    }
    
    private func setupContent() {
        guard let url = Bundle.main.url(forResource: "subscription", withExtension: "mp4") else {
            return
        }
        playerView.setupContent(videoURL: url)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playerView.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        playerView.pause()
    }
    
    @IBAction func showMoreOptionsTapHandler(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func continueTapHandler(_ sender: UIButton) {
        delegate?.continueOnBoarding()
    }
    
    @IBAction func termsOfUseTapHandler(_ sender: UIButton) {
    }
    
    @IBAction func privacyPolicyTapHandler(_ sender: UIButton) {
    }
    
    @IBAction func restoreTapHandler(_ sender: UIButton) {
        
    }
}
