//
//  SwipeUpForMoreViewController.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 13.07.2021.
//

import UIKit

class SwipeUpForMoreViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        imageView.animationImages = UIImage.fromGif(named: "swipe")
        imageView.animationDuration = 1.5
        imageView.animationRepeatCount = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageView.startAnimating()
    }
    
    @IBAction private func swipeUpGestureHandler(_ sender: UISwipeGestureRecognizer) {
        close()
    }
    
    func show(in viewController: UIViewController, animated: Bool = true) {
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        viewController.present(self, animated: animated, completion: nil)
    }
    
    private func close() {
        dismiss(animated: true, completion: nil)
    }
}
