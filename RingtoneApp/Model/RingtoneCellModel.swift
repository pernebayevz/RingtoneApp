//
//  RingtoneCellModel.swift
//  RingtoneCellModel
//
//  Created by Zhangali Pernebayev on 22.07.2021.
//

import Foundation
import AVFoundation

class RingtoneCellModel {
    let ringtoneModel: RingtoneModel
    let asset: AVAsset
    var playerLooper: AVPlayerLooper?
    
    init(ringtoneModel: RingtoneModel, asset: AVAsset) {
        self.ringtoneModel = ringtoneModel
        self.asset = asset
    }
}
