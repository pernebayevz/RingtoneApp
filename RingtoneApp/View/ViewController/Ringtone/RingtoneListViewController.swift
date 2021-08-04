//
//  RingtoneListViewController.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import UIKit
import RxCocoa
import RxSwift
import NotificationBannerSwift

class RingtoneListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let viewModel: RingtoneListViewModel
    
    init(dataSource: [PlayerModel] = []) {
        viewModel = RingtoneListViewModel(dataSource: dataSource)
        super.init(nibName: "RingtoneListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(viewModel, action: #selector(viewModel.fetchRingtones), for: .valueChanged)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(UINib(nibName: RingtoneTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: RingtoneTableViewCell.nibName)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.willDisplayCell.subscribe(onNext: {[unowned tableView] event in
            guard let tableView = tableView, let cell = event.cell as? RingtoneTableViewCell else { return }
            guard !tableView.isDragging && !tableView.isDecelerating else { return }
            cell.play()
        }).disposed(by: disposeBag)
        tableView.rx.didEndDisplayingCell.subscribe(onNext: { event in
            guard let cell = event.cell as? RingtoneTableViewCell else { return }
            cell.pause()
        }).disposed(by: disposeBag)
        tableView.rx.didEndDecelerating.subscribe(onNext: {[unowned tableView] in
            guard let tableView = tableView, let cell = tableView.visibleCells.first as? RingtoneTableViewCell else {
                return
            }
            cell.play()
        }).disposed(by: disposeBag)
        
        viewModel.cellRingtones.bind(to: tableView.rx.items(cellIdentifier: RingtoneTableViewCell.nibName, cellType: RingtoneTableViewCell.self)) { (row,item,cell) in
            cell.setupContent(with: item)
            cell.ringtonePlayerView.delegate = self
        }.disposed(by: disposeBag)
        viewModel.errorMessage.subscribe {[unowned self] errorMessage in
            self.show(errorMessage: errorMessage)
        }.disposed(by: disposeBag)
        viewModel.isFetching.subscribe(onNext: {[unowned self] isFetching in
            if isFetching {
                self.tableView.refreshControl?.beginRefreshing()
            }else{
                self.tableView.refreshControl?.endRefreshing()
            }
        }).disposed(by: disposeBag)
        
        viewModel.fetchRingtonesIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let swipePopup = SwipeUpForMoreViewController()
        swipePopup.show(in: self)
        if let cell = tableView.visibleCells.first as? RingtoneTableViewCell {
            cell.play()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let cell = tableView.visibleCells.first as? RingtoneTableViewCell {
            cell.pause()
        }
    }
}

extension RingtoneListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height
    }
}

extension RingtoneListViewController: RingtonePlayerViewDelegate {
    func share(ringtone: PlayerModel?) {
        guard let ringtone = ringtone, let url = URL(string: ringtone.ringtoneModel.url) else {
            return
        }
        
        let items: [Any] = ["Check out this cool ringtone", url]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
}
