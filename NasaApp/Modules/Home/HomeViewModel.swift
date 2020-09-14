//
//  HomeViewModel.swift
//  NasaApp
//
//  Created by Juan Camilo on 14/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol IHomeViewModel {
    var apodItems: BehaviorRelay<[ApodItem]> { get set }
    var apodViewModel: IApodViewModel { get set }
}

class HomeViewModel: IHomeViewModel {
    var apodItems: BehaviorRelay<[ApodItem]>
    var apodViewModel: IApodViewModel
    var disposeBag = DisposeBag()
    
    init(apodViewModel: IApodViewModel = ApodViewModel()) {
        self.apodViewModel = apodViewModel
        
        apodItems = BehaviorRelay<[ApodItem]>(value: [])
        setupEvenst()
    }
    
    func setupEvenst() {
        apodViewModel.output.response
            .asObservable()
            .bind(to: apodItems)
            .disposed(by: disposeBag)
    }
        
}
