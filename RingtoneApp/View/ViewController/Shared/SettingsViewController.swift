//
//  SettingsViewController.swift
//  SettingsViewController
//
//  Created by Zhangali Pernebayev on 22.07.2021.
//

import UIKit
import RxCocoa
import RxSwift
import StoreKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var crownBtn: UIBarButtonItem = {[unowned self] in
        let btn = UIButton()
        btn.setImage(UIImage(named: "crown2"), for: .normal)
        btn.addTarget(self, action: #selector(crownBtnTapHandler(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }()
    
    private let viewModel = SettingsViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        navigationItem.title = "Settings"
        navigationItem.rightBarButtonItem = crownBtn
        
        tableView.register(UINib(nibName: SettingsTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: SettingsTableViewCell.nibName)
        tableView.rx.itemSelected.subscribe(onNext: {[unowned self] indexPath in
            self.didSelectCell(at: indexPath)
        }).disposed(by: disposeBag)
        
        viewModel.dataSource.bind(to: tableView.rx.items(cellIdentifier: SettingsTableViewCell.nibName, cellType: SettingsTableViewCell.self)) { (row,item,cell) in
            cell.setup(imageName: item.imageName, title: item.title)
        }.disposed(by: disposeBag)
        viewModel.generateSettings()
    }
    
    private func didSelectCell(at indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            openSafari(with: "")
        case 1:
            openSafari(with: "")
        case 2:
            openSafari(with: "")
        case 3:
            SKStoreReviewController.requestReview()
        case 4:
            openSubscriptionPage()
        case 5:
            ()
        case 6:
            share(items: ["Hey, check out this amazing app"])
        case 7:
            openSafari(with: "")
        case 8:
            clearCache()
        default:
            ()
        }
    }
    
    private func openSafari(with url: String) {
        guard let url = URL(string: url) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc private func crownBtnTapHandler(_ sender: UIButton) {
        openSubscriptionPage()
    }
    
    private func openSubscriptionPage() {
        let subscriptionVC = SubscriptionViewController()
        navigationController?.pushViewController(subscriptionVC, animated: true)
    }
    
    private func share(items: [Any]) {
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    private func clearCache() {
        URLCache.shared.removeAllCachedResponses()
        
        let alert = UIAlertController(title: "Cache cleared successfully", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
