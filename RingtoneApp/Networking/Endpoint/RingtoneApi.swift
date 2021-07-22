//
//  RingtoneApi.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 16.07.2021.
//

import Foundation

enum NetworkEnvironment {
    case qa, production, staging
}

public enum RingtoneApi {
    case callList
    case main
}

extension RingtoneApi: EndPointType {
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production:
            return "http://206.189.192.180"
        case .qa:
            return "http://206.189.192.180"
        case .staging:
            return "http://206.189.192.180"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .callList:
            return "/call.json"
        case .main:
            return "/main-ios.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
