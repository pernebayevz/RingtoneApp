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

class PlayerView: UIView {
    
    //MARK: Subviews
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aView = UIActivityIndicatorView(style: .whiteLarge)
        aView.hidesWhenStopped = true
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
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
    private var playerItemContext = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    deinit {
        queuePlayer?.currentItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), context: &playerItemContext)
    }
    
    private func setupView() {
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.contentsGravity = .resizeAspectFill
        playerLayer.backgroundColor = UIColor.black.cgColor
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(_:))))
        addPreviewImageView()
        addActivityIndicatorView()
    }
    
    private func addPreviewImageView() {
        insertSubview(previewImageView, at: 0)
        previewImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        previewImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        previewImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        previewImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func addActivityIndicatorView() {
        insertSubview(activityIndicatorView, at: 1)
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
    
    @objc private func tapGestureHandler(_ sender: UITapGestureRecognizer) {
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // Only handle observations for the playerItemContext
        guard context == &playerItemContext else {
            super.observeValue(forKeyPath: keyPath,
                               of: object,
                               change: change,
                               context: context)
            return
        }

        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }

            // Switch over status value
            switch status {
            case .readyToPlay:
                // Player item is ready to play.
                activityIndicatorView.stopAnimating()
            case .failed:
                // Player item failed. See error.
                activityIndicatorView.stopAnimating()
            case .unknown:
                ()
            @unknown default:
                ()
            }
        }
    }
}

extension PlayerView {
    func prepareForReuse() {
        previewImageView.image = nil
        activityIndicatorView.stopAnimating()
        playerLooper = nil
        queuePlayer = nil
    }
    
    func setupContent(videoURL: String, previewImageURL: String) {
        if let previewImageURL = URL(string: previewImageURL) {
            previewImageView.kf.setImage(with: previewImageURL)
        }
        if let videoURL = URL(string: videoURL) {
            let asset: AVAsset = AVAsset(url: videoURL)
            let playerItem : AVPlayerItem = AVPlayerItem(asset: asset)
            self.queuePlayer = AVQueuePlayer(playerItem: playerItem)
            self.playerLooper = AVPlayerLooper(player: self.queuePlayer!, templateItem: playerItem)
            
            activityIndicatorView.startAnimating()
            playerItem.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.old, .new], context: &playerItemContext)
        }
    }
    
    func play() {
        queuePlayer?.playImmediately(atRate: 1)
    }
    
    func pause() {
        queuePlayer?.pause()
    }
}
