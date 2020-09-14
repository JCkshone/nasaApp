//
//  ApodViewModel.swift
//  NasaApp
//
//  Created by Juan Camilo on 13/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol IApodViewModel: class {
    var output : Output<[ApodItem]> { get set }
    var doApodItems: BehaviorRelay<Void> { get set }
}

class ApodViewModel: IApodViewModel {
    var doApodItems: BehaviorRelay<Void>
    var output: Output<[ApodItem]>
    var manager: IApodManager
    
    init(manager: IApodManager = ApodManager()) {
        self.manager = manager
        let prDoApodItems = BehaviorRelay<Void>(value: ())
        let prErrorRelay = PublishRelay<String>()
        
        let result = prDoApodItems
            .flatMapLatest { (_) -> Observable<[ApodItem]> in manager.getApodRangeDate() }
            .asDriver { (err) -> Driver<[ApodItem]> in
                prErrorRelay.accept((err as? ErrorResult)?.localizedDescription ?? err.localizedDescription)
                return Driver.just([])
        }
        
        doApodItems = prDoApodItems
        
        output = Output(response: result, errorMessage: prErrorRelay.asDriver(onErrorJustReturn: "An error happened"))
    }
    
}
