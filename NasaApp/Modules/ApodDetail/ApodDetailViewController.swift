//
//  ApodDetailViewController.swift
//  NasaApp
//
//  Created by Juan Camilo on 14/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ApodDetailViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?

    @IBOutlet weak var iconPlanet: UIImageView! {
        didSet {
            iconPlanet.image = UIImage(named: icon) ?? UIImage()
        }
    }
    @IBOutlet weak var itemName: UILabel! {
        didSet {
            itemName.text = data?.title
        }
    }
    @IBOutlet weak var itemDescription: UITextView! {
        didSet {
            itemDescription.text = data?.explanation
        }
    }
    @IBOutlet weak var itemDate: UILabel! {
        didSet {
            itemDate.text = data?.date
        }
    }
    @IBOutlet weak var showMore: UIButton! {
        didSet {
            showMore.setTitleColor(ApplicationColor.purpleDark, for: .normal)
        }
    }
    
    var data: ApodItem?
    var icon: String = ""
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEvents()
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ApodDetailViewController {
    func setupEvents() {
        showMore.rx.tap.bind { _ in
            guard let data = self.data else { return }
            self.coordinator?.showAsset(asset: data.url, mediaType: data.media_type)
        }.disposed(by: disposeBag)
    }
}
