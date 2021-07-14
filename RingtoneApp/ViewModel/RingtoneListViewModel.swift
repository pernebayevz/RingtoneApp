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
    let ringtones = PublishSubject<[Ringtone]>()
    
    func fetchRingtones() {
        let ringtones = [
            Ringtone(id: 1, title: "Salam", subtitle: "Ualeikum", videoURL: "", shareLink: ""),
            Ringtone(id: 1, title: "Salam", subtitle: "Ualeikum", videoURL: "", shareLink: ""),
            Ringtone(id: 1, title: "Salam", subtitle: "Ualeikum", videoURL: "", shareLink: ""),
            Ringtone(id: 1, title: "Salam", subtitle: "Ualeikum", videoURL: "", shareLink: ""),
            Ringtone(id: 1, title: "Salam", subtitle: "Ualeikum", videoURL: "", shareLink: ""),
            Ringtone(id: 1, title: "Salam", subtitle: "Ualeikum", videoURL: "", shareLink: ""),
            Ringtone(id: 1, title: "Salam", subtitle: "Ualeikum", videoURL: "", shareLink: ""),
        ]
        self.ringtones.onNext(ringtones)
    }
    
    func refetchRingtones() {
        
    }
    
    func fetchMoreRingtones() {
        
    }
}
