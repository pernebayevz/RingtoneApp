//
//  HomeLiveTableViewCell.swift
//  HomeLiveTableViewCell
//
//  Created by Zhangali Pernebayev on 26.07.2021.
//

import UIKit

class HomeLiveTableViewCell: HomeTabBaseTableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        titleLabel.text = "Live"
        collectionView = LiveCollectionView()
    }

}
