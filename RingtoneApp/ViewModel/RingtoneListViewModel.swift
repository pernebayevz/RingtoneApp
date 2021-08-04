//
//  RingtoneListViewModel.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay
import AVFoundation

class RingtoneListViewModel {
    let ringtones = PublishSubject<[URLModel]>()
    let cellRingtones = BehaviorSubject<[PlayerModel]>(value: [])
    let networkManager = NetworkManager()
    let errorMessage = PublishSubject<String>()
    let disposeBag = DisposeBag()
    let isFetching = PublishSubject<Bool>()
    
    init(dataSource: [PlayerModel] = []) {
        cellRingtones.onNext(dataSource)
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
    
    func fetchRingtonesIfNeeded() {
        if let value = try? cellRingtones.value() {
            if value.count == 0 {
                fetchRingtones()
            }
        }else{
            fetchRingtones()
        }
    }
    
    func refetchRingtones() {
        
    }
    
    func fetchMoreRingtones() {
        
    }
    
    func generateCellRingtones(ringtones: [URLModel]) {
        let cells = ringtones.compactMap { ringtone -> PlayerModel? in
            let cell = PlayerModel(ringtoneModel: ringtone)
            return cell
        }
        cellRingtones.onNext(cells)
    }
}
