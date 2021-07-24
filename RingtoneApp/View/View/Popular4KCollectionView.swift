//
//  Popular4KCollectionView.swift
//  Popular4KCollectionView
//
//  Created by Zhangali Pernebayev on 23.07.2021.
//

import UIKit

protocol Popular4KCollectionViewDelegate: AnyObject {
    func didSelectPopular4KCollectionViewCell(at indexPath: IndexPath)
    func popular4KCollectionViewDidScroll(xOffset: CGFloat)
}

class Popular4KCollectionView: UICollectionView {

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
    
    weak var popular4kDelegate: Popular4KCollectionViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }
    
    func setupCollectionView() {
        contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 0)
        register(UINib(nibName: ImageCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.nibName)
        dataSource = self
        delegate = self
    }
}

extension Popular4KCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.nibName, for: indexPath) as! ImageCollectionViewCell
        return cell
    }
}

extension Popular4KCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        popular4kDelegate?.didSelectPopular4KCollectionViewCell(at: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        popular4kDelegate?.popular4KCollectionViewDidScroll(xOffset: scrollView.contentOffset.x)
    }
}

extension Popular4KCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = bounds.height - contentInset.top - contentInset.bottom
        return CGSize(width: height, height: height)
    }
}
