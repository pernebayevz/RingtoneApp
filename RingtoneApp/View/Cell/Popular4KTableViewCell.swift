//
//  Popular4KTableViewCell.swift
//  Popular4KTableViewCell
//
//  Created by Zhangali Pernebayev on 23.07.2021.
//

import UIKit

class Popular4KTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: Popular4KCollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    private func setupCell() {
        
    }
    
}
