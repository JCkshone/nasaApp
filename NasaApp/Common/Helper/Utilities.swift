//
//  Utilities.swift
//  NasaApp
//
//  Created by Juan Camilo on 14/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import Foundation


class Utilities {
    static let share = Utilities()
    
    func getAssetType(asset: String, mediaType: String) -> AssetType {
        
        if mediaType == ApplicationConstants.imageAsset {
            return .image
        }
        
        if asset.contains(ApplicationConstants.youtubeAsset) {
            return .youtube
        }
        return .video
    }
}
