//
//  OnBoardingViewController.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 16.07.2021.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var pages: [UIViewController] = []
    var currentPageIndex: Int = 0
    var pageViewController: UIPageViewController!
    
    var onExit: (()->())?
    
    deinit {
        onExit = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
    }
    
    private func setupPages() {
        let boredURL = Bundle.main.url(forResource: "bored", withExtension: "mp4")
        let vc1 = TitleSubtitleActionViewController(title: "Bored of the same ringtone every time?", subtitle: "Express yourself, even through incoming calls", videoURL: boredURL)
        vc1.delegate = self
        pages.append(vc1)
        
        let memorable = Bundle.main.url(forResource: "memorable", withExtension: "mp4")
        let vc2 = TitleSubtitleActionViewController(title: "Make an ordinary call memorable", subtitle: "Choose from numerous ringtones and personalize your call experience", videoURL: memorable)
        vc2.delegate = self
        pages.append(vc2)
        
        let vc3 = SubscriptionViewController()
        vc3.delegate = self
        pages.append(vc3)
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        contentView.addSubview(pageViewController.view)
        addChild(pageViewController)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // constrain it to all 4 sides
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        pageViewController.didMove(toParent: self)
        
//        pageViewController.dataSource = self
        
        setupPages()
        pageViewController.setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
    }
    
    @IBAction func closeBtnTapHandler(_ sender: UIButton) {
        onExit?()
    }
}
extension OnBoardingViewController: OnBoardingDelegate {
    func continueOnBoarding() {
        if currentPageIndex < pages.count - 1 {
            currentPageIndex += 1
            pageViewController.setViewControllers([pages[currentPageIndex]], direction: .forward, animated: true, completion: nil)
        }
        if currentPageIndex == 2 {
            closeBtn.isHidden = false
        }
    }
}
//
//extension OnBoardingViewController: UIPageViewControllerDataSource {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
//            if viewControllerIndex == 0 {
//                // wrap to last page in array
//                return self.pages.last
//            } else {
//                // go to previous page in array
//                return self.pages[viewControllerIndex - 1]
//            }
//        }
//        return nil
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
//            if viewControllerIndex < self.pages.count - 1 {
//                // go to next page in array
//                return self.pages[viewControllerIndex + 1]
//            } else {
//                // wrap to first page in array
//                return self.pages.first
//            }
//        }
//        return nil
//    }
//}
