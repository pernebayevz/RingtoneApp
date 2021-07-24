//
//  HomeViewController.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 15.07.2021.
//

import UIKit
import RxCocoa
import RxSwift
import NotificationBannerSwift

class HomeViewController: UIViewController {

    lazy var settingsBtn: UIBarButtonItem = {[unowned self] in
        let btn = UIButton()
        btn.setImage(UIImage(named: "gear"), for: .normal)
        btn.addTarget(self, action: #selector(settingsBtnTapHandler(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }()
    lazy var crownBtn: UIBarButtonItem = {[unowned self] in
        let btn = UIButton()
        btn.setImage(UIImage(named: "crown2"), for: .normal)
        btn.addTarget(self, action: #selector(crownBtnTapHandler(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }()
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
        
        viewModel.delegate = self
        viewModel.fetchData()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Collection"
        navigationItem.leftBarButtonItem = settingsBtn
        navigationItem.rightBarButtonItem = crownBtn
    }
    
    private func setupView() {
        tableView.register(UINib(nibName: FlashCallTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: FlashCallTableViewCell.nibName)
        tableView.register(UINib(nibName: LiveTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: LiveTableViewCell.nibName)
        tableView.register(UINib(nibName: Popular4KTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: Popular4KTableViewCell.nibName)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func settingsBtnTapHandler(_ sender: UIButton) {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc private func crownBtnTapHandler(_ sender: UIButton) {
        let subscriptionVC = SubscriptionViewController()
        navigationController?.pushViewController(subscriptionVC, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: FlashCallTableViewCell.nibName, for: indexPath) as! FlashCallTableViewCell
            cell.topCall = viewModel.mainData?.topcall
            cell.collectionView.currentXOffset = viewModel.topCallXOffset
            cell.collectionView.flashCallDelegate = self
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: LiveTableViewCell.nibName, for: indexPath) as! LiveTableViewCell
            cell.collectionView.items = viewModel.liveData
            cell.collectionView.currentXOffset = viewModel.topLiveXOffset
            cell.collectionView.liveCollectionViewDelegate = self
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Popular4KTableViewCell.nibName, for: indexPath) as! Popular4KTableViewCell
            cell.collectionView.items = viewModel.liveData
            cell.collectionView.currentXOffset = viewModel.topLiveXOffset
            cell.collectionView.popular4kDelegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let topCallVC = RingtoneListViewController()
            navigationController?.pushViewController(topCallVC, animated: true)
        default:
            ()
        }
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func errorDidAppear(message: String) {
        let banner = NotificationBanner(title: "Couldn't fetch data", subtitle: message, style: .danger)
        banner.show()
    }
    
    func readyToReloadData() {
        tableView.reloadData()
    }
}

extension HomeViewController: FlashCallCollectionViewDelegate {
    func didSelect(ringtone: RingtoneModel) {
        let vc = RingtoneViewController(ringtone: ringtone)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func flashCallScrollViewDidScroll(xOffset: CGFloat) {
        viewModel.topCallXOffset = xOffset
    }
}

extension HomeViewController: LiveCollectionViewDelegate {
    func liveCollectionViewDidScroll(xOffset: CGFloat) {
        viewModel.topLiveXOffset = xOffset
    }
    
    func didSelectLiveCollectionViewCell(at indexPath: IndexPath) {
        let ringtone = viewModel.liveData[indexPath.item]
        let vc = WallPaperViewController(type: .live(videoURL: ringtone.ringtoneModel.videoURL))
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: Popular4KCollectionViewDelegate {
    func popular4KCollectionViewDidScroll(xOffset: CGFloat) {
        viewModel.popular4KXOffset = xOffset
    }
    
    func didSelectPopular4KCollectionViewCell(at indexPath: IndexPath) {
        
    }
}
