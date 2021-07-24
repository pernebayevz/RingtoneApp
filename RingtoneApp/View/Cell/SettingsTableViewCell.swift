//
//  SettingsTableViewCell.swift
//  SettingsTableViewCell
//
//  Created by Zhangali Pernebayev on 22.07.2021.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.image = nil
        titleLabel.text = nil
    }
    
    func setup(imageName: String, title: String) {
        iconImageView.image = UIImage(named: imageName)
        titleLabel.text = title
    }
}
