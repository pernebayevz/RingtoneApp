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
        tableView.rx.didEndScrollingAnimation.subscribe { _ in
            print("tableView didEndScrollingAnimation")
        }.disposed(by: disposeBag)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.ringtones.bind(to: tableView.rx.items(cellIdentifier: RingtoneTableViewCell.nibName, cellType: RingtoneTableViewCell.self)) { (row,item,cell) in
                    
        }.disposed(by: disposeBag)
        viewModel.fetchRingtones()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        viewModel.fetchRingtones()
//        print("view bounds: \(view.bounds)")
//        print("view.safeAreaInsets: \(view.safeAreaInsets)")
//        print("view.safeAreaLayoutGuide.layoutFrame: \(view.safeAreaLayoutGuide.layoutFrame)")
//        print("view.safeAreaLayoutGuide.topAnchor: \(view.safeAreaLayoutGuide.topAnchor)")
//        print("view.safeAreaLayoutGuide.bottomAnchor: \(view.safeAreaLayoutGuide.bottomAnchor)")
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
