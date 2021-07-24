//
//  LiveTableViewCell.swift
//  LiveTableViewCell
//
//  Created by Zhangali Pernebayev on 23.07.2021.
//

import UIKit

class LiveTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowRightBtn: UIButton!
    @IBOutlet weak var collectionView: LiveCollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
}
