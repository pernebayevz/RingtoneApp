//
//  SettingsViewModel.swift
//  SettingsViewModel
//
//  Created by Zhangali Pernebayev on 22.07.2021.
//

import Foundation
import RxCocoa
import RxSwift

struct SettingsModel {
    let imageName: String
    let title: String
}

class SettingsViewModel {
    let dataSource = PublishSubject<[SettingsModel]>()
    
    func generateSettings() {
        let array: [SettingsModel] = [
            SettingsModel(imageName: "file", title: "Privacy policy"),
            SettingsModel(imageName: "tick_in_rectangle", title: "Use Conditions"),
            SettingsModel(imageName: "tick_in_comment_bubble", title: "Support"),
            SettingsModel(imageName: "star_linear", title: "Estimate"),
            SettingsModel(imageName: "crown_bold", title: "Go to Premium"),
            SettingsModel(imageName: "recover", title: "Recover"),
            SettingsModel(imageName: "share_bold", title: "Invite friends"),
            SettingsModel(imageName: "instagram", title: "Join the community"),
            SettingsModel(imageName: "brush", title: "Clear cache"),
        ]
        dataSource.onNext(array)
    }
}
