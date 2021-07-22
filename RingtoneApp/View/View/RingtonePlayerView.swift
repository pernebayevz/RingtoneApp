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
    func share(ringtone: RingtoneCellModel?)
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
    
    private let disposeBag = DisposeBag()
    private var ringTone: RingtoneCellModel?
    weak var delegate: RingtonePlayerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        xibSetup()
        subscribeToButtonTaps()
        playerView.delegate = self
    }
    
    private func subscribeToButtonTaps() {
        shareBtn.tapEvent.subscribe(onNext: {[unowned self] in
            print("shareBtn tapped")
            self.delegate?.share(ringtone: ringTone)
        }).disposed(by: disposeBag)
        likeBtn.tapEvent.subscribe(onNext: {
            print("likeBtn tapped")
        }).disposed(by: disposeBag)
        pauseOrPlayBtn.tapEvent.subscribe(onNext: {[unowned playerView] in
            print("pauseOrPlayBtn tapped")
            playerView?.playOrPauseVideoImmediately()
        }).disposed(by: disposeBag)
        saveBtn.tapEvent.subscribe(onNext: {
            print("saveBtn tapped")
        }).disposed(by: disposeBag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func prepareForReuse() {
        pauseOrPlayBtn.set(title: "Stop", image: UIImage(named: "stop"))
    }
    
    func setupContent(with ringtone: RingtoneCellModel) {
        self.ringTone = ringtone
        
        if let url = URL(string: ringtone.ringtoneModel.videoURL) {
            if ringtone.player == nil {
                let asset = AVAsset(url: url)
                let item = AVPlayerItem(asset: asset)
                ringtone.player = AVQueuePlayer(playerItem: item)
                ringtone.playerLooper = AVPlayerLooper(player: ringtone.player!, templateItem: item)
            }
            playerView.player = ringtone.player!
        }else{
            playerView.player = nil
        }
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
