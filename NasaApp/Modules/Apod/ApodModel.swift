//
//  ApodModel.swift
//  NasaApp
//
//  Created by Juan Camilo on 13/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import Foundation

struct ApodItem: Codable {
    let date: String
    let explanation: String
    let media_type: String
    let title: String
    let url: String
}
