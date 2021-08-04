//
//  NewTableViewCell.swift
//  NewTableViewCell
//
//  Created by Zhangali Pernebayev on 26.07.2021.
//

import UIKit

class NewTableViewCell: HomeTabBaseTableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        titleLabel.text = "New"
        collectionView = Popular4KCollectionView()
    }
}
