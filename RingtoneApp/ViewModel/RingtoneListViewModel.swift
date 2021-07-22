//
//  RingtoneListViewModel.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import Foundation
import RxCocoa
import RxSwift
import AVFoundation

class RingtoneListViewModel {
    let ringtones = PublishSubject<[RingtoneModel]>()
    let cellRingtones = PublishSubject<[RingtoneCellModel]>()
    let networkManager = NetworkManager()
    let errorMessage = PublishSubject<String>()
    let disposeBag = DisposeBag()
    let isFetching = PublishSubject<Bool>()
    
    init() {
        ringtones.subscribe(onNext: {[unowned self] ringtones in
            self.generateCellRingtones(ringtones: ringtones)
        }).disposed(by: disposeBag)
    }
    
    @objc func fetchRingtones() {
        isFetching.onNext(true)
        networkManager.getCallList {[weak self] ringtones, error in
            DispatchQueue.main.sync {[weak self] in
                self?.isFetching.onNext(false)
                
                if let ringtones = ringtones {
                    self?.ringtones.onNext(ringtones.shuffled())
                }else if let error = error {
                    self?.errorMessage.onNext(error)
                }
            }
        }
    }
    
    func refetchRingtones() {
        
    }
    
    func fetchMoreRingtones() {
        
    }
    
    func generateCellRingtones(ringtones: [RingtoneModel]) {
        let cells = ringtones.compactMap { ringtone -> RingtoneCellModel? in
            let cell = RingtoneCellModel(ringtoneModel: ringtone)
            return cell
        }
        cellRingtones.onNext(cells)
    }
}
