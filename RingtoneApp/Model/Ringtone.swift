//
//  Ringtone.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 14.07.2021.
//

import Foundation

struct RingtoneModel: Codable {
    let preview_url, url: String
    
    var videoURL: String {
        return RingtoneApi.callList.environmentBaseURL + url
    }
    var previewImageURL: String {
        return RingtoneApi.callList.environmentBaseURL + preview_url
    }
}

struct CallAPIResponse: Codable {
    let id: Int
    let nameCategory, urlPhoto: String
    let array: [RingtoneModel]
}

protocol TopCallProtocol: Codable {
    var link: String { get set }
    var nameCategory: String { get set }
    var urlPhoto: String { get set }
    var array: [RingtoneModel] { get set }
}

struct TopCallModel: TopCallProtocol {
    var link, nameCategory, urlPhoto: String
    var array: [RingtoneModel]
}

struct TopLiveModel: TopCallProtocol {
    var link, nameCategory, urlPhoto: String
    var array: [RingtoneModel]
}

struct CategoryModel: Codable {
    var link, nameCategory, urlPhoto: String
}

struct ChargeModel: TopCallProtocol {
    var link, nameCategory, urlPhoto: String
    var array: [RingtoneModel]
}

struct MainModel: Codable {
    var topcall: TopCallModel
    var toplive: TopLiveModel
    var popular_4k, popular_live, categories_all: [CategoryModel]
    var charge: ChargeModel
}
