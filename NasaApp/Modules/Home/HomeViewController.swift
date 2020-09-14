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
import Koloda

class HomeViewController: UIViewController {
    @IBOutlet weak var tabbarView: Tabbar!
    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var reloadBtn: UIButton!
    
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
        tabbarView.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 35)
        kolodaView.dataSource = self
        kolodaView.delegate = self
        setupBg()
    }
    
    func setupRxEvents() {
        viewModel?.apodItems.asObservable().bind(onNext: { items in
            self.kolodaView.reloadData()
        }).disposed(by: disposeBag)
        
        reloadBtn.rx.tap.bind { _ in
            let oldApods = self.viewModel?.apodItems.value ?? []
            self.viewModel?.apodItems.accept([])
            self.viewModel?.apodItems.accept(oldApods)
        }.disposed(by: disposeBag)
    }
}

extension HomeViewController: KolodaViewDataSource {
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let swipe = SwipeCard()
        swipe.rootSwipeCard.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 35)
        if let data = viewModel?.apodItems.value[index] {
            swipe.data = data
            swipe.coordinator = self.coordinator
        }
        return swipe
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        viewModel?.apodItems.value.count ?? 0
    }
}

extension HomeViewController: KolodaViewDelegate {
    
}
