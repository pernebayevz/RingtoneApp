//
//  RingtonePlayerView.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import AVFoundation

protocol RingtonePlayerViewDelegate: AnyObject {
    func share(ringtone: PlayerModel?)
}

@IBDesignable
class RingtonePlayerView: UIView {

    @IBOutlet weak var playerView: VideoPlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var shareBtn: VerticalButton!
    @IBOutlet weak var likeBtn: VerticalButton!
    @IBOutlet weak var pauseOrPlayBtn: VerticalButton!
    @IBOutlet weak var saveBtn: VerticalButton!
    
    private var ringTone: PlayerModel?
    weak var delegate: RingtonePlayerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    deinit {
        print("deinit RingtonePlayerView")
    }
    
    private func setupView() {
        xibSetup()
        subscribeToButtonTaps()
        playerView.delegate = self
    }
    
    private func subscribeToButtonTaps() {
        _ = shareBtn.tapEvent.subscribe(onNext: {[unowned self] in
            print("shareBtn tapped")
            self.delegate?.share(ringtone: ringTone)
        })
        _ = likeBtn.tapEvent.subscribe(onNext: {
            print("likeBtn tapped")
        })
        _ = pauseOrPlayBtn.tapEvent.subscribe(onNext: {[unowned playerView] in
            print("pauseOrPlayBtn tapped")
            playerView?.playOrPauseVideoImmediately()
        })
        _ = saveBtn.tapEvent.subscribe(onNext: {
            print("saveBtn tapped")
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func prepareForReuse() {
        pauseOrPlayBtn.set(title: "Stop", image: UIImage(named: "stop"))
        playerView.player = nil
        ringTone = nil
        delegate = nil
    }
    
    func setupContent(with ringtone: PlayerModel) {
        self.ringTone = ringtone
        
        if ringtone.player == nil, let url = URL(string: ringtone.ringtoneModel.videoURL) {
            let asset = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset)
            let player = AVQueuePlayer(playerItem: playerItem)
            ringtone.player = player
            ringtone.playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        }
        playerView.player = ringtone.player
    }
    
    func play() {
        playerView.playVideoImmediately()
    }
    
    func pause() {
        playerView.pauseVideo()
    }
}

extension RingtonePlayerView: VideoPlayerViewDelegate {
    func didPlay() {
        pauseOrPlayBtn.set(title: "Stop", image: UIImage(named: "stop"))
    }
    
    func didPause() {
        pauseOrPlayBtn.set(title: "Play", image: UIImage(named: "play"))
    }
}
