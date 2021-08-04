//
//  RingtoneCellModel.swift
//  RingtoneCellModel
//
//  Created by Zhangali Pernebayev on 22.07.2021.
//

import Foundation
import AVFoundation

class PlayerModel {
    let ringtoneModel: URLModel
    var player: AVQueuePlayer?
    var playerLooper: AVPlayerLooper?
    
    init(ringtoneModel: URLModel) {
        self.ringtoneModel = ringtoneModel
    }
}
