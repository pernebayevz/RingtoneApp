//
//  Popular4KCollectionView.swift
//  Popular4KCollectionView
//
//  Created by Zhangali Pernebayev on 23.07.2021.
//

import UIKit
import Kingfisher

class Popular4KCollectionView: HomeBaseCollectionView {
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
        register(UINib(nibName: ImageCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.nibName)
        delegate = self
    }
}

extension Popular4KCollectionView {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.nibName, for: indexPath) as! ImageCollectionViewCell
        let item = items[indexPath.item] as! BaseModel
        cell.imageView.kf.setImage(with: URL(string: item.urlPhotoFull))
        cell.gradientBgImageView.isHidden = false
        cell.tagLabel.isHidden = false
        cell.tagLabel.text = item.nameCategory
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = bounds.height - contentInset.top - contentInset.bottom
        return CGSize(width: height, height: height)
    }
}
