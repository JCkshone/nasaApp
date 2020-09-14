//
//  MainCoordinator.swift
//  NasaApp
//
//  Created by Juan Camilo on 13/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func splash() {
        let vc = HomeViewController()
        let viewModel = HomeViewModel()
        
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showApodDetail(item: ApodItem, image: String) {
        let vc = ApodDetailViewController()
        vc.coordinator = self
        vc.icon = image
        vc.data = item
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAsset(asset: String, mediaType: String) {
        guard Utilities.share.getAssetType(asset: asset, mediaType: mediaType) != .video else {
            showVideoFromUrl(videoPath: asset)
            return
        }
        let vc = ShowAssetViewController()
        vc.asset = asset
        vc.mediaType = mediaType
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showVideoFromUrl(videoPath: String) {
        guard let url = URL(string: videoPath) else { return }
        let player = AVPlayer(url: url)
        let vc = AVPlayerViewController()
        
        vc.player = player

        navigationController.present(vc, animated: true) {
            vc.player?.play()
        }
    }
}
