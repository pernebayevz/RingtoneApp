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
    
    func fetchRingtones() {
        let ringtones = [
            RingtoneModel(preview_url: "http://206.189.192.180/call/37.jpg", url: "http://206.189.192.180/call/37.mp4"),
            RingtoneModel(preview_url: "http://206.189.192.180/call/103.jpg", url: "http://206.189.192.180/call/103.mp4"),
            RingtoneModel(preview_url: "http://206.189.192.180/call/155.jpg", url: "http://206.189.192.180/call/155.mp4"),
            RingtoneModel(preview_url: "http://206.189.192.180/call/27.jpg", url: "http://206.189.192.180/call/27.mp4"),
            RingtoneModel(preview_url: "http://206.189.192.180/call/74.jpg", url: "http://206.189.192.180/call/74.mp4"),
            RingtoneModel(preview_url: "http://206.189.192.180/call/55.jpg", url: "http://206.189.192.180/call/55.mp4"),
        ]
        self.ringtones.onNext(ringtones)
    }
    
    func refetchRingtones() {
        
    }
    
    func fetchMoreRingtones() {
        
    }
}
