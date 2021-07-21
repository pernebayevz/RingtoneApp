//
//  Onboarding1CollectionViewCell.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 19.07.2021.
//

import UIKit

class Onboarding1CollectionViewCell: UICollectionViewCell, OnBoardingCellProtocol {
    static let nibName: String = "Onboarding1CollectionViewCell"
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var continueBtn: UIButton!
    
    var indexPath: IndexPath?
    weak var delegate: OnBoardingDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    @IBAction private func continueBtnTapHandler(_ sender: UIButton) {
        delegate?.continueOnBoarding(indexPath: indexPath)
    }
    
    func setupContent(title: String?, subtitle: String?, indexPath: IndexPath) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        self.indexPath = indexPath
    }
}
