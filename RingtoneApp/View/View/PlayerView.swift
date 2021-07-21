//
//  PlayerView.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import UIKit
import AVFoundation
import Kingfisher
import RxCocoa
import RxSwift

protocol PlayerViewDelegate: AnyObject {
    func didPause()
    func didPlay()
}

class PlayerView: UIView {
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    private var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    private var playerLooper: AVPlayerLooper?
    private var queuePlayer: AVQueuePlayer? {
        get {
            return playerLayer.player as? AVQueuePlayer
        }
        set {
            playerLayer.player = newValue
        }
    }
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    weak var delegate: PlayerViewDelegate?
    
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
        addPreviewImageView()
    }
    
    private func addPreviewImageView() {
        insertSubview(previewImageView, at: 0)
        previewImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        previewImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        previewImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        previewImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    @objc private func tapGestureHandler(_ sender: UITapGestureRecognizer) {
        pauseOrPlay()
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        // Only handle observations for the playerItemContext
//        guard context == &playerItemContext else {
//            super.observeValue(forKeyPath: keyPath,
//                               of: object,
//                               change: change,
//                               context: context)
//            return
//        }
//
//        if keyPath == #keyPath(AVPlayerItem.status) {
//            let status: AVPlayerItem.Status
//            if let statusNumber = change?[.newKey] as? NSNumber {
//                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
//            } else {
//                status = .unknown
//            }
//
//            // Switch over status value
//            switch status {
//            case .readyToPlay:
//                // Player item is ready to play.
//                stopAnimating()
//            case .failed:
//                // Player item failed. See error.
//                stopAnimating()
//            case .unknown:
//                ()
//            @unknown default:
//                ()
//            }
//        }
//    }
}

extension PlayerView {
    func prepareForReuse() {
        previewImageView.image = nil
        playerLooper = nil
        queuePlayer = nil
    }
    
    func setupContent(videoURL: String, previewImageURL: String? = nil) {
        setupContent(videoURL: URL(string: videoURL), previewImageURL: previewImageURL)
    }
    
    func setupContent(videoURL: URL?, previewImageURL: String? = nil) {
        if let urlString = previewImageURL, let previewImageURL = URL(string: urlString) {
            previewImageView.kf.setImage(with: previewImageURL)
        }
        if let videoURL = videoURL {
            let asset: AVAsset = AVAsset(url: videoURL)
            let playerItem : AVPlayerItem = AVPlayerItem(asset: asset)
            self.queuePlayer = AVQueuePlayer(playerItem: playerItem)
            self.queuePlayer!.automaticallyWaitsToMinimizeStalling = false
            self.playerLooper = AVPlayerLooper(player: self.queuePlayer!, templateItem: playerItem)
        }
    }
    
    func play() {
        guard let player = queuePlayer else { return }
        
        player.playImmediately(atRate: 1)
        delegate?.didPlay()
    }
    
    func pause() {
        queuePlayer?.pause()
        delegate?.didPause()
    }
    
    func pauseOrPlay() {
        guard let player = queuePlayer else {
            return
        }
        
        switch player.timeControlStatus {
        case .paused:
            play()
        case .playing:
            pause()
        case .waitingToPlayAtSpecifiedRate:
            play()
        @unknown default:
            ()
        }
    }
}
