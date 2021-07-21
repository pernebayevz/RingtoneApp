//
//  VideoPlayerView.swift
//  VideoPlayerView
//
//  Created by Zhangali Pernebayev on 21.07.2021.
//

import UIKit
import AVFoundation

protocol VideoPlayerProtocol {
    var player: AVQueuePlayer? { get set }
    var currentPlayerItem: AVPlayerItem? { get }
    
    func playVideoImmediately(at rate: Float)
    func pauseVideo()
    func playOrPauseVideoImmediately(at rate: Float)
    func advanceToNextPlayerItem()
    func remove(playerItem: AVPlayerItem)
}

protocol VideoPlayerViewDelegate: AnyObject {
    func didPause()
    func didPlay()
}

class VideoPlayerView: UIView, VideoPlayerProtocol {

    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    private var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    weak var delegate: VideoPlayerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        playerLayer.videoGravity = .resizeAspectFill
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(_:))))
    }
    
    @objc private func tapGestureHandler(_ sender: UITapGestureRecognizer) {
        playOrPauseVideoImmediately()
    }
    
    func prepareForReuse() {
        player = nil
        delegate = nil
    }
}

extension VideoPlayerView {
    var player: AVQueuePlayer? {
        get {
            return playerLayer.player as? AVQueuePlayer
        }
        set {
            playerLayer.player = newValue
            playerLayer.player?.automaticallyWaitsToMinimizeStalling = false
        }
    }
    var currentPlayerItem: AVPlayerItem? {
        get {
            return player?.currentItem
        }
    }
    
    func playVideoImmediately(at rate: Float = 1.0) {
        guard let player = player else {
            return
        }
        player.playImmediately(atRate: rate)
    }
    
    func pauseVideo() {
        guard let player = player else {
            return
        }
        player.pause()
    }
    
    func playOrPauseVideoImmediately(at rate: Float = 1.0) {
        guard let player = player else {
            return
        }
        
        switch player.timeControlStatus {
        case AVPlayer.TimeControlStatus.paused:
            playVideoImmediately(at: rate)
        case AVPlayer.TimeControlStatus.playing:
            pauseVideo()
        default:
            ()
        }
    }
    
    func advanceToNextPlayerItem() {
        player?.advanceToNextItem()
    }
    
    func remove(playerItem: AVPlayerItem) {
        player?.remove(playerItem)
    }
}
