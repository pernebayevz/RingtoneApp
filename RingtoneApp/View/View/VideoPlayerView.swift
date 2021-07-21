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
    var playerLooper: AVPlayerLooper? { get set }
    var playerItem: AVPlayerItem? { get set }
    var playerItems: [AVPlayerItem]? { get set }
    var shouldRepeat: Bool { get set }
    
    func playVideo()
    func playVideoImmediately(at rate: Float)
    func pauseVideo()
    func playOrPauseVideo()
    func seek(to time: CMTime, completionHandler: ((Bool)->())?)
    func seekAndPlay(time: CMTime)
    
    func playVideoImmediately(playerItem: AVPlayerItem, shouldRepeat: Bool)
    func play(startTime: CMTime, endTime: CMTime)
}

class VideoPlayerView: UIView, VideoPlayerProtocol {

    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    private var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    var playerLooper: AVPlayerLooper?
    var shouldRepeat: Bool = true {
        didSet {
            if shouldRepeat {
                if let player = player, let item = player.currentItem {
                    playerLooper = AVPlayerLooper(player: player, templateItem: item)
                }
            }else{
                playerLooper = nil
            }
        }
    }
    
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
        playOrPauseVideo()
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
    var playerItem: AVPlayerItem? {
        get {
            return playerLayer.player?.currentItem
        }
        set {
            if player == nil {
                player = AVQueuePlayer(playerItem: newValue)
            }else{
                player?.replaceCurrentItem(with: newValue)
            }
            if shouldRepeat {
                if let item = newValue {
                    playerLooper = AVPlayerLooper(player: player!, templateItem: item)
                }
            }else{
                playerLooper = nil
            }
        }
    }
    var playerItems: [AVPlayerItem]? {
        get {
            return player?.items()
        }
        set {
            if let items = newValue {
                player = AVQueuePlayer(items: items)
                
                if shouldRepeat {
                    if let item = player?.currentItem {
                        playerLooper = AVPlayerLooper(player: player!, templateItem: item)
                    }
                }else{
                    playerLooper = nil
                }
            }else{
                player = nil
            }
        }
    }
    
    func playVideo() {
        player?.play()
    }
    
    func playVideoImmediately(at rate: Float) {
        player?.playImmediately(atRate: rate)
    }
    
    func pauseVideo() {
        player?.pause()
    }
    
    func playOrPauseVideo() {
        guard let player = player else {
            return
        }
        
        switch player.timeControlStatus {
        case .paused:
            playVideoImmediately(at: 1.0)
        case .playing:
            pauseVideo()
        default:
            ()
        }
    }
    
    func seek(to time: CMTime, completionHandler: ((Bool) -> ())? = nil) {
        if let completionHandler = completionHandler {
            player?.seek(to: time, completionHandler: completionHandler)
        }else{
            player?.seek(to: time)
        }
    }
    
    func seekAndPlay(time: CMTime) {
        seek(to: time) {[unowned self] succeeded in
            if succeeded {
                self.playVideoImmediately(at: 1.0)
                
            }
        }
    }
    
    func playVideoImmediately(playerItem: AVPlayerItem, shouldRepeat: Bool = true) {
        if let player = player {
            player.replaceCurrentItem(with: playerItem)
        }else{
            player = AVQueuePlayer(playerItem: playerItem)
        }
        if shouldRepeat {
            playerLooper = AVPlayerLooper(player: player!, templateItem: playerItem)
        }
        
        playVideoImmediately(at: 1.0)
    }
    
    func play(startTime: CMTime, endTime: CMTime) {
        guard let player = player, let item = player.currentItem else {
            return
        }
        
        player.removeAllItems()
        playerLooper = AVPlayerLooper(player: player, templateItem: item, timeRange: CMTimeRange(start: startTime, duration: endTime))
        
        playVideoImmediately(at: 1.0)
        
        ///Comment
        
        guard let playerItem = player.currentItem else {
            return
        }
        
        let duration = playerItem.duration
        let currentTime = playerItem.currentTime()
        let difference: Double = duration.seconds - currentTime.seconds
        
        player.rate = Float(difference)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            
        }
    }
}
