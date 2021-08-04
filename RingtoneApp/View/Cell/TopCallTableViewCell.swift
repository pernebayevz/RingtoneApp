//
//  TopCallTableViewCell.swift
//  TopCallTableViewCell
//
//  Created by Zhangali Pernebayev on 25.07.2021.
//

import UIKit

class TopCallTableViewCell: HomeTabBaseTableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        titleLabel.text = "Flash Call"
        collectionView = TopCallCollectionView()
    }
}
