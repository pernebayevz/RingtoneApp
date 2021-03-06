//
//  Popular4KTableViewCell.swift
//  Popular4KTableViewCell
//
//  Created by Zhangali Pernebayev on 26.07.2021.
//

import UIKit

class Popular4KTableViewCell: HomeTabBaseTableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        titleLabel.text = "Popular 4K"
        collectionView = Popular4KCollectionView()
    }
}
