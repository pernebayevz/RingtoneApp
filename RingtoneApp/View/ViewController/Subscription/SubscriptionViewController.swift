//
//  SubscriptionViewController.swift
//  SubscriptionViewController
//
//  Created by Zhangali Pernebayev on 20.07.2021.
//

import UIKit
import AVFoundation

class SubscriptionViewController: UIViewController {

    @IBOutlet weak var subscriptionView: SubscriptionView!
    var playerLooper: AVPlayerLooper?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        subscriptionView.delegate = self
        if let url = Bundle.main.url(forResource: "subscription", withExtension: "mp4") {
            let asset = AVAsset(url: url)
            let item = AVPlayerItem(asset: asset)
            let player = AVQueuePlayer(playerItem: item)
            subscriptionView.playerView.player = player
            playerLooper = AVPlayerLooper(player: player, templateItem: item)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscriptionView.playerView.playVideoImmediately()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        subscriptionView.playerView.pauseVideo()
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
