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

protocol RingtonePlayerViewDelegate: AnyObject {
    func share(ringtone: RingtoneModel?)
}

@IBDesignable
class RingtonePlayerView: UIView {

    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var shareBtn: VerticalButton!
    @IBOutlet weak var likeBtn: VerticalButton!
    @IBOutlet weak var pauseOrPlayBtn: VerticalButton!
    @IBOutlet weak var saveBtn: VerticalButton!
    
    private let disposeBag = DisposeBag()
    private var ringTone: RingtoneModel?
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
            playerView?.pauseOrPlay()
        }).disposed(by: disposeBag)
        saveBtn.tapEvent.subscribe(onNext: {
            print("saveBtn tapped")
        }).disposed(by: disposeBag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func prepareForReuse() {
        playerView.prepareForReuse()
    }
    
    func setupContent(with ringtone: RingtoneModel) {
        self.ringTone = ringtone
        playerView.setupContent(videoURL: RingtoneApi.callList.environmentBaseURL + ringtone.url, previewImageURL: RingtoneApi.callList.environmentBaseURL + ringtone.preview_url)
    }
    
    func play() {
        playerView.play()
    }
    
    func pause() {
        playerView.pause()
    }
}

extension RingtonePlayerView: PlayerViewDelegate {
    func didPlay() {
        pauseOrPlayBtn.set(title: "Stop", image: UIImage(named: "stop"))
    }
    
    func didPause() {
        pauseOrPlayBtn.set(title: "Play", image: UIImage(named: "play"))
    }
}
