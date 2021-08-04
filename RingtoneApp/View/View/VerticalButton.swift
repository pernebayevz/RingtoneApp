//
//  VerticalButton.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import UIKit
import RxCocoa
import RxSwift

@IBDesignable
class VerticalButton: UIView {
    
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
    
    let tapEvent = PublishSubject<Void>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    deinit {
        tapEvent.dispose()
    }
    
    func setupView() {
        xibSetup()
        stackView.spacing = 0
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:))))
        titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:))))
    }
    
    @objc private func tapHandler(_ sender: UITapGestureRecognizer) {
        tapEvent.onNext(())
    }
    
    func set(title: String?, image: UIImage?) {
        titleLabel.text = title
        imageView.image = image
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return titleLabel.frame.contains(point) || imageView.frame.contains(point)
    }
}
