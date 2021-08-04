//
//  TopCallListViewController.swift
//  TopCallListViewController
//
//  Created by Zhangali Pernebayev on 25.07.2021.
//

import UIKit
import NotificationBannerSwift
import RxCocoa
import RxSwift
import AVFoundation

class TopCallListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = RingtoneListViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }

    private func setupViewController() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(viewModel, action: #selector(viewModel.fetchRingtones), for: .valueChanged)
        collectionView.register(UINib(nibName: RingtoneCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: RingtoneCollectionViewCell.nibName)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.cellRingtones.bind(to: collectionView.rx.items(cellIdentifier: RingtoneCollectionViewCell.nibName, cellType: RingtoneCollectionViewCell.self)) { (row,item,cell) in
            //let ringtone = items[indexPath.item]
            if item.player == nil, let url = URL(string: item.ringtoneModel.videoURL) {
                let asset = AVAsset(url: url)
                let playerItem = AVPlayerItem(asset: asset)
                let player = AVQueuePlayer(playerItem: playerItem)
                item.player = player
                item.playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
            }
            cell.videoPlayerView.player = item.player
            cell.videoPlayerView.player?.isMuted = true
        }.disposed(by: disposeBag)
        viewModel.errorMessage.subscribe {[unowned self] errorMessage in
            self.show(errorMessage: errorMessage)
        }.disposed(by: disposeBag)
        viewModel.isFetching.subscribe(onNext: {[unowned self] isFetching in
            if isFetching && !collectionView.refreshControl!.isRefreshing {
                self.collectionView.refreshControl!.beginRefreshing()
            } else if !isFetching && collectionView.refreshControl!.isRefreshing {
                self.collectionView.refreshControl!.endRefreshing()
            }
        }).disposed(by: disposeBag)
        
        viewModel.fetchRingtones()
    }
}

extension TopCallListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! RingtoneCollectionViewCell).videoPlayerView.playVideoImmediately()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! RingtoneCollectionViewCell).videoPlayerView.pauseVideo()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if var dataSource = try? viewModel.cellRingtones.value() {
            let item = dataSource.remove(at: indexPath.item)
            dataSource.insert(item, at: 0)
            let vc = RingtoneListViewController(dataSource: dataSource)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratio: CGFloat = 212/114
        let leftInset: CGFloat = collectionView.contentInset.left
        let rightInset: CGFloat = collectionView.contentInset.right
        let cellSpace: CGFloat = 10
        let cellsCount: CGFloat = 3.0
        let width: CGFloat = (collectionView.bounds.width - leftInset - rightInset - (cellSpace*(cellsCount-1))) / cellsCount
        let height: CGFloat = width * ratio
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension UIViewController {
    func show(errorMessage: String) {
        let banner = NotificationBanner(title: "Couldn't fetch ringtones", subtitle: errorMessage, style: .danger)
        banner.show()
    }
}
