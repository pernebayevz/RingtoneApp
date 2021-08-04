//
//  LiveCollectionView.swift
//  LiveCollectionView
//
//  Created by Zhangali Pernebayev on 23.07.2021.
//

import UIKit
import AVFoundation

class LiveCollectionView: HomeBaseCollectionView {
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        setupCell()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        register(UINib(nibName: LiveCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: LiveCollectionViewCell.nibName)
        delegate = self
    }
}

extension LiveCollectionView {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: LiveCollectionViewCell.nibName, for: indexPath) as! LiveCollectionViewCell
        let ringtone = items[indexPath.item] as! PlayerModel
        if ringtone.player == nil, let url = URL(string: ringtone.ringtoneModel.videoURL) {
            let asset = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset)
            let player = AVQueuePlayer(playerItem: playerItem)
            ringtone.player = player
            ringtone.playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        }
        cell.videoPlayerView.player = ringtone.player
        cell.videoPlayerView.player?.isMuted = true
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = bounds.height - contentInset.top - contentInset.bottom
        let leftInset: CGFloat = contentInset.left
        let cellSpace: CGFloat = 10
        let cellsCount: CGFloat = 3.2
        let width: CGFloat = (bounds.width - leftInset - (cellSpace*cellsCount.rounded(.towardZero))) / cellsCount
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? LiveCollectionViewCell {
            cell.videoPlayerView.playVideoImmediately()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? LiveCollectionViewCell {
            cell.videoPlayerView.pauseVideo()
        }
    }
}
