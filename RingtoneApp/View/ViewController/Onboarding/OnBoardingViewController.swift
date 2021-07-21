//
//  OnBoardingViewController.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 16.07.2021.
//

import UIKit
import RxCocoa
import RxSwift

protocol OnBoardingDelegate: AnyObject {
    func continueOnBoarding(indexPath: IndexPath?)
}

protocol OnBoardingCellProtocol {
    var indexPath: IndexPath? { get set }
    var delegate: OnBoardingDelegate? { get set }
}

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let disposeBag = DisposeBag()
    
    var onExit: (()->())?
    
    deinit {
        onExit = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(UINib(nibName: Onboarding1CollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: Onboarding1CollectionViewCell.nibName)
        collectionView.register(UINib(nibName: Onboarding2CollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: Onboarding2CollectionViewCell.nibName)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func closeBtnTapHandler(_ sender: UIButton) {
        onExit?()
    }
}

extension OnBoardingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemAt: \(indexPath.item)")
        switch indexPath.item {
        case 0, 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Onboarding1CollectionViewCell.nibName, for: indexPath) as! Onboarding1CollectionViewCell
            if indexPath.item == 0 {
                let boredURL = Bundle.main.url(forResource: "bored", withExtension: "mp4")
                cell.setupContent(title: "Bored of the same ringtone every time?", subtitle: "Express yourself, even through incoming calls", indexPath: indexPath)
            }else{
                let memorableURL = Bundle.main.url(forResource: "memorable", withExtension: "mp4")
                cell.setupContent(title: "Make an ordinary call memorable", subtitle: "Choose from numerous ringtones and personalize your call experience", indexPath: indexPath)
            }
            cell.delegate = self
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Onboarding2CollectionViewCell.nibName, for: indexPath) as! Onboarding2CollectionViewCell
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }
}


extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            closeBtn.isHidden = false
        }else{
            closeBtn.isHidden = true
        }
    }
}

extension OnBoardingViewController: OnBoardingDelegate {
    func continueOnBoarding(indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        
        if indexPath.item < collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            let nextIndexPath = IndexPath(item: indexPath.item+1, section: indexPath.section)
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: false)
        }
    }
}
