//
//  HomeViewModel.swift
//  HomeViewModel
//
//  Created by Zhangali Pernebayev on 22.07.2021.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func errorDidAppear(message: String)
    func readyToReloadData()
}

class HomeViewModel {
    let networkManager = NetworkManager()
    weak var delegate: HomeViewModelDelegate?
    var mainData: MainModel?
    
    var topCallXOffset: CGFloat = 0
    
    func fetchData() {
        networkManager.getMain {[weak self] mainData, error in
            DispatchQueue.main.sync {[weak self, mainData] in
                if var mainData = mainData {
                    mainData.topcall.array.shuffle()
                    self?.mainData = mainData
                    self?.delegate?.readyToReloadData()
                }else if let error = error {
                    self?.delegate?.errorDidAppear(message: error)
                }
            }
        }
    }
}
