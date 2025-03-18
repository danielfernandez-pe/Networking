//
//  CustomDecoder.swift
//  Networking
//
//  Created by Daniel Fernandez Yopla on 29.12.2024.
//

import Foundation

struct CustomDecoder {
    static let main: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        decoder.dataDecodingStrategy = .deferredToData
        
        decoder.userInfo = [
            CodingUserInfoKey(rawValue: "caseInsensitiveEnumDecoding")!: true
        ]
        return decoder
    }()
}
