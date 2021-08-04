//
//  Onboarding2CollectionViewCell.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 19.07.2021.
//

import UIKit

class Onboarding2CollectionViewCell: UICollectionViewCell, OnBoardingCellProtocol {
    @IBOutlet private weak var subscriptionView: SubscriptionView!
    
    var indexPath: IndexPath?
    weak var delegate: OnBoardingDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subscriptionView.delegate = self
    }
}

extension Onboarding2CollectionViewCell: SubscriptionViewDelegate {
    func didTapShowMoreOptions() {}
    
    func didTapTermsOfUse() {}
    
    func didTapPrivacyPolicy() {}
    
    func didTapRestore() {}
    
    func didTapContinue() {
        delegate?.continueOnBoarding(indexPath: indexPath)
    }
}
