//
//  FlashCallCollectionView.swift
//  FlashCallCollectionView
//
//  Created by Zhangali Pernebayev on 22.07.2021.
//

import UIKit
import Kingfisher

protocol MainCollectionViewDelegate: AnyObject {
    func mainCollectionViewDidScroll(xOffset: CGFloat, tableViewCellIndexPath: IndexPath?)
    func mainCollectionViewDidSelect(indexPath: IndexPath, tableViewCellIndexPath: IndexPath?)
}

protocol MainCollectionViewProtocol {
    var items: [Any] { get set }
    var xOffset: CGFloat? { get set }
    var mainDelegate: MainCollectionViewDelegate? { get set }
}

class HomeBaseCollectionView: UICollectionView, MainCollectionViewProtocol {
    var items: [Any] = [] {
        didSet {
            reloadData()
        }
    }
    var xOffset: CGFloat? {
        didSet {
            if let xOffset = xOffset {
                setContentOffset(CGPoint(x: xOffset, y: 0), animated: false)
            }else{
                setContentOffset(CGPoint(x: -contentInset.left, y: 0), animated: false)
            }
        }
    }
    weak var mainDelegate: MainCollectionViewDelegate?
    var tableViewCellIndexPath: IndexPath?
    
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
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        dataSource = self
        delegate = self
    }
}

extension HomeBaseCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension HomeBaseCollectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mainDelegate?.mainCollectionViewDidScroll(xOffset: scrollView.contentOffset.x, tableViewCellIndexPath: tableViewCellIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainDelegate?.mainCollectionViewDidSelect(indexPath: indexPath, tableViewCellIndexPath: tableViewCellIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {}
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {}
}

class TopCallCollectionView: HomeBaseCollectionView {
    
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
        register(UINib(nibName: RingtoneCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: RingtoneCollectionViewCell.nibName)
        delegate = self
    }
}

extension TopCallCollectionView {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: RingtoneCollectionViewCell.nibName, for: indexPath) as! RingtoneCollectionViewCell
        let item = items[indexPath.item] as! URLModel
        cell.imageView.kf.setImage(with: URL(string: item.previewImageURL))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = bounds.height - contentInset.top - contentInset.bottom
        let leftInset: CGFloat = contentInset.left
        let cellSpace: CGFloat = 12.0
        let cellsCount: CGFloat = 2.5
        let width: CGFloat = (bounds.width - leftInset - (cellSpace*cellsCount.rounded(.towardZero))) / cellsCount
        return CGSize(width: width, height: height)
    }
}
