//
//  LiveCollectionView.swift
//  LiveCollectionView
//
//  Created by Zhangali Pernebayev on 23.07.2021.
//

import UIKit
import AVFoundation

protocol LiveCollectionViewDelegate: AnyObject {
    func didSelectLiveCollectionViewCell(at indexPath: IndexPath)
    func liveCollectionViewDidScroll(xOffset: CGFloat)
}

class LiveCollectionView: UICollectionView {

    var items: [RingtoneCellModel] = [] {
        didSet {
            reloadData()
        }
    }
    var currentXOffset: CGFloat = 0 {
        didSet {
            setContentOffset(CGPoint(x: currentXOffset, y: 0), animated: false)
        }
    }
    
    weak var liveCollectionViewDelegate: LiveCollectionViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }

    private func setupCollectionView() {
        contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 0)
        register(UINib(nibName: LiveCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: LiveCollectionViewCell.nibName)
        dataSource = self
        delegate = self
    }
}

extension LiveCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: LiveCollectionViewCell.nibName, for: indexPath) as! LiveCollectionViewCell
        let ringtone = items[indexPath.item]
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
}

extension LiveCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? LiveCollectionViewCell {
            cell.videoPlayerView.playVideoImmediately()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? LiveCollectionViewCell {
            cell.videoPlayerView.pauseVideo()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        liveCollectionViewDelegate?.didSelectLiveCollectionViewCell(at: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        liveCollectionViewDelegate?.liveCollectionViewDidScroll(xOffset: scrollView.contentOffset.x)
    }
}

extension LiveCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = bounds.height - contentInset.top - contentInset.bottom
        let leftInset: CGFloat = contentInset.left
        let cellSpace: CGFloat = (collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing
        let cellsCount: CGFloat = 3.2
        let width: CGFloat = (bounds.width - leftInset - (cellSpace*cellsCount.rounded(.towardZero))) / cellsCount
        return CGSize(width: width, height: height)
    }
}
