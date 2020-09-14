//
//  NasaAppConstants.swift
//  NasaApp
//
//  Created by Juan Camilo on 13/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import Foundation

struct ApplicationConstants {
    static let apiKey = Configuration.shared.getValueConfiguration(withType: String.self, key: .publicKey)
    static let baseUrl = Configuration.shared.getValueConfiguration(withType: String.self, key: .baseUrl)
    static let apiKeyPath = "api_key"
    static let datePath = "date"
    static let customErrorMessages = "Failded data load"
    static let dateFormat = "yyyy-MM-dd"
    static let requestDay = -7
}
