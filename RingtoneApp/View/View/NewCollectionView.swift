//
//  NewCollectionView.swift
//  NewCollectionView
//
//  Created by Zhangali Pernebayev on 26.07.2021.
//

import UIKit


class NewCollectionView: HomeBaseCollectionView {
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
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
        contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        register(UINib(nibName: ImageCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.nibName)
        delegate = self
    }
}

extension NewCollectionView {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.nibName, for: indexPath) as! ImageCollectionViewCell
        let item = items[indexPath.item] as! BaseModel
        cell.imageView.kf.setImage(with: URL(string: item.urlPhotoFull))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let minLineSpacing: CGFloat = (collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing
        let minInteritemSpacing: CGFloat = (collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing
        let height: CGFloat = (bounds.height - contentInset.top - contentInset.bottom - minLineSpacing)/2
        let width: CGFloat = (bounds.width - contentInset.left - contentInset.right - minInteritemSpacing)/2
        return CGSize(width: width, height: height)
    }
}
