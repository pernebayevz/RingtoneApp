//
//  ParameterEncoding.swift
//  RingtoneApp
//
//  Created by Zhangali Pernebayev on 16.07.2021.
//

import Foundation

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
