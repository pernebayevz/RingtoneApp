//
//  FlashCallTableViewCell.swift
//  FlashCallTableViewCell
//
//  Created by Zhangali Pernebayev on 22.07.2021.
//

import UIKit

protocol FlashCallTableViewCellDelegate: AnyObject {
    func didSelectFlashCallCell()
}

class FlashCallTableViewCell: UITableViewCell {
    static let nibName: String = "FlashCallTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowRightBtn: UIButton!
    @IBOutlet weak var collectionView: FlashCallCollectionView!
    @IBOutlet weak var labelStackView: UIStackView!
    
    var topCall: TopCallModel? {
        didSet {
            collectionView.items = topCall?.array ?? []
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    private func setupCell() {
        selectionStyle = .none
//        labelStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:))))
    }
    
    @objc private func tapHandler(_ sender: UITapGestureRecognizer) {
        
    }
}
