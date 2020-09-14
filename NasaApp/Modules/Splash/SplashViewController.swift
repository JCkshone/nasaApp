//
//  SplashViewController.swift
//  NasaApp
//
//  Created by Juan Camilo on 12/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SplashViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var apodViewModel: IApodViewModel?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        apodViewModel?.output.response
            .asObservable().bind(onNext: { items in
                print(items)
            }).disposed(by: disposeBag)
    }
}
