//
//  RingtoneCollectionViewCell.swift
//  RingtoneCollectionViewCell
//
//  Created by Zhangali Pernebayev on 22.07.2021.
//

import UIKit

class RingtoneCollectionViewCell: UICollectionViewCell {
    static let nibName: String = "RingtoneCollectionViewCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    private func setupCell() {
        containerView.layer.cornerRadius = 10
    }
}
