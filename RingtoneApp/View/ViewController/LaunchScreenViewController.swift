//
//  LaunchScreenViewController.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 13.07.2021.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {

    private var animationCompletionBlock: LottieCompletionBlock?
    @IBOutlet weak var animationView: AnimationView!
    
    init(animationCompletionBlock: @escaping LottieCompletionBlock) {
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
        
        guard let animation = Animation.named("call") else {
            animationCompletionBlock?(false)
            return
        }
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundBehavior = .forceFinish
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animationView.play(completion: animationCompletionBlock)
    }
}
