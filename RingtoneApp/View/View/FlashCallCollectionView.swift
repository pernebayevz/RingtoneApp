//
//  FlashCallCollectionView.swift
//  FlashCallCollectionView
//
//  Created by Zhangali Pernebayev on 22.07.2021.
//

import UIKit
import Kingfisher

protocol FlashCallCollectionViewDelegate: AnyObject {
    func flashCallScrollViewDidScroll(xOffset: CGFloat)
    func didSelect(ringtone: RingtoneModel)
}

class FlashCallCollectionView: UICollectionView {
    
    var items = [RingtoneModel](){
        didSet {
            reloadData()
        }
    }
    var currentXOffset: CGFloat = 0 {
        didSet {
            setContentOffset(CGPoint(x: currentXOffset, y: 0), animated: false)
        }
    }
    
    weak var flashCallDelegate: FlashCallCollectionViewDelegate?
    
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
        register(UINib(nibName: RingtoneCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: RingtoneCollectionViewCell.nibName)
        dataSource = self
        delegate = self
    }
}

extension FlashCallCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: RingtoneCollectionViewCell.nibName, for: indexPath) as! RingtoneCollectionViewCell
        let item = items[indexPath.item]
        cell.imageView.kf.setImage(with: URL(string: item.previewImageURL))
        return cell
    }
}

extension FlashCallCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = bounds.height - contentInset.top - contentInset.bottom
        let leftInset: CGFloat = contentInset.left
        let cellSpace: CGFloat = (collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing
        let cellsCount: CGFloat = 2.5
        let width: CGFloat = (bounds.width - leftInset - (cellSpace*cellsCount.rounded(.towardZero))) / cellsCount
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        flashCallDelegate?.flashCallScrollViewDidScroll(xOffset: scrollView.contentOffset.x)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ringtone = items[indexPath.item]
        flashCallDelegate?.didSelect(ringtone: ringtone)
    }
}
