//
//  SubscriptionView.swift
//  SubscriptionView
//
//  Created by Zhangali Pernebayev on 20.07.2021.
//

import UIKit

protocol SubscriptionViewDelegate: AnyObject {
    func didTapShowMoreOptions()
    func didTapTermsOfUse()
    func didTapPrivacyPolicy()
    func didTapRestore()
    func didTapContinue()
}

@IBDesignable
class SubscriptionView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var playerView: VideoPlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainVStackView: UIStackView!
    @IBOutlet weak var unlimitedAccessImageView: UIImageView!
    @IBOutlet weak var bottomVStackView: UIStackView!
    @IBOutlet weak var subscriptionDetailsVStackView: UIStackView!
    @IBOutlet weak var moreOptionsBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var termsOfUseBtn: UIButton!
    @IBOutlet weak var privacyPolicyBtn: UIButton!
    @IBOutlet weak var restoreBtn: UIButton!
    
    weak var delegate: SubscriptionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    deinit {
        delegate = nil
    }
    
    private func setupView() {
        xibSetup()
        moreOptionsBtn.setImage(UIImage(named: "arrow_up"), for: .selected)
    }
    
    @IBAction func showMoreOptions(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        delegate?.didTapShowMoreOptions()
    }
    
    @IBAction func termsOfUse(_ sender: UIButton) {
        delegate?.didTapTermsOfUse()
    }
    
    @IBAction func privacyPolicy(_ sender: UIButton) {
        delegate?.didTapPrivacyPolicy()
    }
    
    @IBAction func restore(_ sender: UIButton) {
        delegate?.didTapRestore()
    }
}
