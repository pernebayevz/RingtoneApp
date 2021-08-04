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
    var isFetching: Bool {get set}
}

class HomeViewModel {
    private let networkManager = NetworkManager()
    weak var delegate: HomeViewModelDelegate?
    var mainData: MainModel? {
        didSet {
            generateLiveData()
        }
    }
    var liveData: [PlayerModel] = []
    
    let numberOfRows: Int = 4
    lazy var xOffsetArray: [CGFloat?] = Array(repeating: nil, count: numberOfRows)
    
    init(delegate: HomeViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    @objc func fetchData() {
        delegate?.isFetching = true
        networkManager.getMain {[weak self] mainData, error in
            DispatchQueue.main.sync {[weak self, mainData] in
                self?.delegate?.isFetching = false
                
                if var mainData = mainData {
                    mainData.topcall.array?.shuffle()
                    self?.mainData = mainData
                    self?.delegate?.readyToReloadData()
                }else if let error = error {
                    self?.delegate?.errorDidAppear(message: error)
                }
            }
        }
    }
    
    func generateLiveData() {
        guard let mainData = mainData, let topLiveArray = mainData.toplive.array else {
            return
        }
        liveData = topLiveArray.map { ringtone in
            return PlayerModel(ringtoneModel: ringtone)
        }
    }
}
