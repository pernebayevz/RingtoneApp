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
    var player: AVQueuePlayer?
    var playerLooper: AVPlayerLooper?
    
    init(ringtoneModel: RingtoneModel) {
        self.ringtoneModel = ringtoneModel
    }
}
