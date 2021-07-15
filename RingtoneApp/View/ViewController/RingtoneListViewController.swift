//
//  RingtoneListViewController.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import UIKit
import RxCocoa
import RxSwift

class RingtoneListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let viewModel = RingtoneListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
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
        
        viewModel.ringtones.bind(to: tableView.rx.items(cellIdentifier: RingtoneTableViewCell.nibName, cellType: RingtoneTableViewCell.self)) { (row,item,cell) in
            cell.setupContent(with: item)
        }.disposed(by: disposeBag)
        viewModel.fetchRingtones()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchRingtones()
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
