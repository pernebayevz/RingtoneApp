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
    
    private let viewModel = HomeViewModel()
    var isFetching: Bool = false {
        didSet {
            isFetchingValueChanged()
        }
    }
    
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
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(viewModel, action: #selector(viewModel.fetchData), for: .valueChanged)
        tableView.register(TopCallTableViewCell.self, forCellReuseIdentifier: TopCallTableViewCell.nibName)
        tableView.register(HomeLiveTableViewCell.self, forCellReuseIdentifier: HomeLiveTableViewCell.nibName)
        tableView.register(Popular4KTableViewCell.self, forCellReuseIdentifier: Popular4KTableViewCell.nibName)
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
    
    private func isFetchingValueChanged() {
        if isFetching && !tableView.refreshControl!.isRefreshing {
            tableView.refreshControl!.beginRefreshing()
        }else if !isFetching && tableView.refreshControl!.isRefreshing {
            tableView.refreshControl!.endRefreshing()
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopCallTableViewCell.nibName, for: indexPath) as! TopCallTableViewCell
            cell.collectionView.items = viewModel.mainData?.topcall.array ?? []
            cell.collectionView.xOffset = viewModel.xOffsetArray[indexPath.row]
            cell.collectionView.tableViewCellIndexPath = indexPath
            cell.collectionView.mainDelegate = self
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeLiveTableViewCell.nibName, for: indexPath) as! HomeLiveTableViewCell
            cell.collectionView.items = viewModel.liveData
            cell.collectionView.xOffset = viewModel.xOffsetArray[indexPath.row]
            cell.collectionView.tableViewCellIndexPath = indexPath
            cell.collectionView.mainDelegate = self
            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Popular4KTableViewCell.nibName, for: indexPath) as! Popular4KTableViewCell
            cell.collectionView.items = viewModel.mainData?.popular_4k ?? []
            cell.collectionView.xOffset = viewModel.xOffsetArray[indexPath.row]
            cell.collectionView.tableViewCellIndexPath = indexPath
            cell.collectionView.mainDelegate = self
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: Popular4KTableViewCell.nibName, for: indexPath) as! Popular4KTableViewCell
            cell.collectionView.items = viewModel.mainData?.popular_live ?? []
            cell.collectionView.xOffset = viewModel.xOffsetArray[indexPath.row]
            cell.collectionView.tableViewCellIndexPath = indexPath
            cell.collectionView.mainDelegate = self
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let topCallVC = TopCallListViewController()
            navigationController?.pushViewController(topCallVC, animated: true)
        default:
            ()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            let ratio: CGFloat = 334/414
            let width: CGFloat = tableView.bounds.width
            let height: CGFloat = ratio * width
            return height
            
        case 1:
            let ratio: CGFloat = 278/414
            let width: CGFloat = tableView.bounds.width
            let height: CGFloat = ratio * width
            return height
            
        case 2:
            let ratio: CGFloat = 134/414
            let width: CGFloat = tableView.bounds.width
            let height: CGFloat = ratio * width
            return height
            
        case 3:
            let ratio: CGFloat = 274/414
            let width: CGFloat = tableView.bounds.width
            let height: CGFloat = ratio * width
            return height
            
        default:
            return 0
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
//
//extension HomeViewController: FlashCallCollectionViewDelegate {
//    func didSelect(ringtone: URLModel) {
//        let vc = RingtoneViewController(ringtone: ringtone)
//        vc.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
//    func flashCallScrollViewDidScroll(xOffset: CGFloat) {
//        viewModel.topCallXOffset = xOffset
//    }
//}
//
//extension HomeViewController: LiveCollectionViewDelegate {
//    func liveCollectionViewDidScroll(xOffset: CGFloat) {
//        viewModel.topLiveXOffset = xOffset
//    }
//
//    func didSelectLiveCollectionViewCell(at indexPath: IndexPath) {
//        let ringtone = viewModel.liveData[indexPath.item]
//        let vc = WallPaperViewController(type: .live(videoURL: ringtone.ringtoneModel.videoURL))
//        vc.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//extension HomeViewController: Popular4KCollectionViewDelegate {
//    func popular4KCollectionViewDidScroll(xOffset: CGFloat) {
//        viewModel.popular4KXOffset = xOffset
//    }
//
//    func didSelectPopular4KCollectionViewCell(at indexPath: IndexPath) {
//
//    }
//}

extension HomeViewController: MainCollectionViewDelegate {
    func mainCollectionViewDidScroll(xOffset: CGFloat, tableViewCellIndexPath: IndexPath?) {
        guard let tableViewCellIndexPath = tableViewCellIndexPath else {
            return
        }
        viewModel.xOffsetArray[tableViewCellIndexPath.row] = xOffset
    }
    
    func mainCollectionViewDidSelect(indexPath: IndexPath, tableViewCellIndexPath: IndexPath?) {
        guard let tableViewCellIndexPath = tableViewCellIndexPath, let mainData = viewModel.mainData else {
            return
        }
        
        var vc: UIViewController?
        switch tableViewCellIndexPath.row {
        case 0:
            let ringtone = mainData.topcall.array![indexPath.item]
            vc = RingtoneViewController(ringtone: ringtone)
        case 1:
            let live = viewModel.liveData[indexPath.item]
            vc = WallPaperViewController(type: .live(videoURL: live.ringtoneModel.videoURL, player: live.player, playerLooper: live.playerLooper))
        default:
            ()
        }
        if vc != nil {
            vc!.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
}
