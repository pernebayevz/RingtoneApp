//
//  VerticalButton.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import UIKit
import RxSwift

@IBDesignable
class VerticalButton: UIView {

    private let kCONTENT_XIB_NAME: String = "VerticalButton"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBInspectable var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    @IBInspectable var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    @IBInspectable var spacing: CGFloat = 0 {
        didSet {
            stackView.spacing = spacing
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        xibSetup()
        stackView.spacing = 0
    }
}
