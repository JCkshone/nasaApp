//
//  HomeViewController.swift
//  NasaApp
//
//  Created by Juan Camilo on 12/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    @IBOutlet weak var tabbarView: Tabbar!
    
    weak var coordinator: MainCoordinator?
    var viewModel: IHomeViewModel?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRxEvents()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupView() {
        self.setupBg()
        tabbarView.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 35)
    }
    
    func setupRxEvents() {
        viewModel?.apodItems.asObservable().bind(onNext: { items in
            print("items", items)
        }).disposed(by: disposeBag)
    }
}
