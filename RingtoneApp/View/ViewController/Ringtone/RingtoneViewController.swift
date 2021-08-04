//
//  RingtoneViewController.swift
//  RingtoneViewController
//
//  Created by Zhangali Pernebayev on 23.07.2021.
//

import UIKit
import AVFoundation

class RingtoneViewController: UIViewController {

    @IBOutlet weak var rintgtonePlayerView: RingtonePlayerView!
    
    let ringtone: URLModel
    var playerLooper: AVPlayerLooper?
    
    init(ringtone: URLModel) {
        self.ringtone = ringtone
        super.init(nibName: "RingtoneViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }

    private func setupViewController() {
        if let url = URL(string: ringtone.videoURL) {
            let asset = AVAsset(url: url)
            let item = AVPlayerItem(asset: asset)
            self.rintgtonePlayerView.playerView.player = AVQueuePlayer(playerItem: item)
            self.playerLooper = AVPlayerLooper(player: self.rintgtonePlayerView.playerView.player!, templateItem: item)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rintgtonePlayerView.playerView.playVideoImmediately()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        rintgtonePlayerView.playerView.pauseVideo()
    }
}
