//
//  LaunchScreenViewController.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 13.07.2021.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {

    private var animationCompletionBlock: (()->())?
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var animationView: AnimationView!
    
    init(animationCompletionBlock: @escaping (()->())) {
        self.animationCompletionBlock = animationCompletionBlock
        super.init(nibName: "LaunchScreenViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        animationCompletionBlock = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        
        guard let animation = Animation.named("call") else {
            animationCompletionBlock?()
            return
        }
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundBehavior = .forceFinish
        
        animationView.play {[weak self, weak contentView] _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut]) {[weak contentView] in
                contentView?.alpha = 0.0
            } completion: {[weak self] _ in
                self?.animationCompletionBlock?()
            }
        }
    }
}
