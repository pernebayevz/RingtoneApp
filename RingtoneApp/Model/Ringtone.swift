//
//  Ringtone.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import Foundation

struct URLModel: Codable {
    let preview_url, url: String
    
    var videoURL: String {
        return RingtoneApi.callList.environmentBaseURL + url
    }
    var previewImageURL: String {
        return RingtoneApi.callList.environmentBaseURL + preview_url
    }
}

struct BaseModel: Codable {
    let id: Int?
    let nameCategory, urlPhoto: String
    let link: String?
    var array: [URLModel]?
    
    var urlPhotoFull: String {
        return RingtoneApi.callList.environmentBaseURL + urlPhoto
    }
    var linkFull: String?  {
        guard let link = link else {
            return nil
        }
        return RingtoneApi.callList.environmentBaseURL + link
    }
}

struct MainModel: Codable {
    var topcall, toplive, charge: BaseModel
    var popular_4k, popular_live, categories_all: [BaseModel]
}
