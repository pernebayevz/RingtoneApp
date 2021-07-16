//
//  RingtoneListViewModel.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import Foundation
import RxCocoa
import RxSwift

class RingtoneListViewModel {
    let ringtones = PublishSubject<[RingtoneModel]>()
    let networkManager = NetworkManager()
    let errorMessage = PublishSubject<String>()
    
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
}
