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
    
    init() {
        ringtones.subscribe(onNext: {[unowned self] ringtones in
            self.generateCellRingtones(ringtones: ringtones)
        }).disposed(by: disposeBag)
    }
    
    func fetchRingtones() {
        networkManager.getCallList {[weak ringtonesObserver = ringtones, weak errorMessage] ringtones, error in
            DispatchQueue.main.sync {[weak ringtonesObserver, ringtones, weak errorMessage] in
                if let ringtones = ringtones {
                    ringtonesObserver?.onNext(ringtones.shuffled())
                }else if let error = error {
                    errorMessage?.onNext(error)
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
            guard let url = URL(string: RingtoneApi.callList.environmentBaseURL + ringtone.url) else { return nil }
            
            let asset = AVAsset(url: url)
            let cell = RingtoneCellModel(ringtoneModel: ringtone, asset: asset)
            return cell
        }
        cellRingtones.onNext(cells)
    }
}
