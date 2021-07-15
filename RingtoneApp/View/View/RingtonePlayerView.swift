//
//  RingtonePlayerView.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import UIKit
import SwiftUI

@IBDesignable
class RingtonePlayerView: UIView {

    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var shareBtn: VerticalButton!
    @IBOutlet weak var likeBtn: VerticalButton!
    @IBOutlet weak var stopOrPlayBtn: VerticalButton!
    @IBOutlet weak var saveBtn: VerticalButton!
    
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func prepareForReuse() {
        playerView.prepareForReuse()
    }
    
    func setupContent(with ringtone: RingtoneModel) {
        playerView.setupContent(videoURL: ringtone.url, previewImageURL: ringtone.preview_url)
    }
    
    func play() {
        playerView.play()
    }
    
    func pause() {
        playerView.pause()
    }
}
