//
//  TitleSubtitleActionViewController.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 16.07.2021.
//

import UIKit

protocol OnBoardingDelegate: AnyObject {
    func continueOnBoarding()
}

class TitleSubtitleActionViewController: UIViewController {

    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    weak var delegate: OnBoardingDelegate?
    private let titleLabelText: String
    private let subTitleLabelText: String
    private let videoURL: URL?
    
    init(title: String, subtitle: String, videoURL: URL? = nil) {
        titleLabelText = title
        subTitleLabelText = subtitle
        self.videoURL = videoURL
        
        super.init(nibName: "TitleSubtitleActionViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("asdasdas")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleLabelText
        subtitleLabel.text = subTitleLabelText
        
        playerView.setupContent(videoURL: videoURL)
        playerView.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        playerView.pause()
    }
    
    @IBAction func continueBtnTapHandler(_ sender: UIButton) {
        delegate?.continueOnBoarding()
    }
}
