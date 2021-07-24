//
//  LiveCollectionViewCell.swift
//  LiveCollectionViewCell
//
//  Created by Zhangali Pernebayev on 23.07.2021.
//

import UIKit

class LiveCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var videoPlayerView: VideoPlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        videoPlayerView.layer.cornerRadius = 10
        videoPlayerView.clipsToBounds = true
    }
}
