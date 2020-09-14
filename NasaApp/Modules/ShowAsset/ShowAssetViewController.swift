//
//  ShowAssetViewController.swift
//  NasaApp
//
//  Created by Juan Camilo on 14/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import UIKit
import YouTubePlayer
import PlayerKit
import AVFoundation

enum AssetType {
    case youtube
    case video
    case image
}

class ShowAssetViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var youtubeViewPlayer: YouTubePlayerView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var assetImage: UIImageView!
    
    var asset: String = ""
    var mediaType: String = ""
    
    var assetType: AssetType = .image {
        didSet {
            setupView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assetType = Utilities.share.getAssetType(asset: asset, mediaType: mediaType)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension ShowAssetViewController {
    
    func setupView() {
        switch assetType {
        case .image:
            loadImage()
        case .youtube:
            youtubeLoad()
        default:
            video()
        }
    }
    
    func loadImage() {
        guard let url = URL(string: asset) else { return }
        assetImage.load(url: url)
        assetImage.isHidden = false
    }
    
    func youtubeLoad() {
        guard let url = URL(string: asset) else { return }
        youtubeViewPlayer.loadVideoURL(url)
        youtubeViewPlayer.isHidden = false
    }
    
    func video() {
        guard let url = URL(string: asset) else { return }
        let player = RegularPlayer()
        videoView.addSubview(player.view)
        videoView.isHidden = false
        player.set(AVURLAsset(url: url))
        player.play()
        
        
    }
}
