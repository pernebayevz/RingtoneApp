//
//  Ringtone.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import Foundation

struct RingtoneModel: Codable {
    let preview_url, url: String
}

struct CallAPIResponse: Codable {
    let id: Int
    let nameCategory, urlPhoto: String
    let array: [RingtoneModel]
}
