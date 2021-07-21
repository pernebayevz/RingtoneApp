//
//  RintoneTableViewCell.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import UIKit
import AVFoundation

class RingtoneTableViewCell: UITableViewCell {

    static let nibName: String = String(describing: RingtoneTableViewCell.self)
    @IBOutlet weak var ringtonePlayerView: RingtonePlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    private func setupCell() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ringtonePlayerView.prepareForReuse()
    }
    
    func setupContent(with ringtone: RingtoneCellModel) {
        ringtonePlayerView.setupContent(with: ringtone)
    }
    
    func play() {
        ringtonePlayerView.play()
    }
    
    func pause() {
        ringtonePlayerView.pause()
    }
}
