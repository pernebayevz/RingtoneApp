//
//  RingtonePlayerView.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import UIKit
import SwiftUI

@IBDesignable
class RingtonePlayerView: UIView {

    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var shareBtn: VerticalButton!
    @IBOutlet weak var likeBtn: VerticalButton!
    @IBOutlet weak var stopOrPlayBtn: VerticalButton!
    @IBOutlet weak var saveBtn: VerticalButton!
    
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
